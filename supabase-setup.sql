-- AAB PRIVATE FINANCE PORTAL — ROLE: SUPER ADMIN + 7 ADMIN
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  display_name text not null,
  role text not null check (role in ('super_admin','admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.org_transactions (
  id uuid primary key default gen_random_uuid(),
  type text not null check (type in ('pemasukan','pengeluaran')),
  amount numeric(16,2) not null check (amount > 0),
  category text not null,
  description text,
  transaction_date date not null default current_date,
  created_by uuid not null references public.profiles(id),
  created_at timestamptz not null default now()
);

create table if not exists public.savings_transactions (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references public.profiles(id),
  type text not null check (type in ('setoran','penarikan')),
  amount numeric(16,2) not null check (amount > 0),
  description text,
  transaction_date date not null default current_date,
  created_by uuid not null references public.profiles(id),
  created_at timestamptz not null default now()
);

create index if not exists savings_member_date_idx on public.savings_transactions(member_id, transaction_date desc);
create index if not exists org_date_idx on public.org_transactions(transaction_date desc);

create or replace function public.is_aab_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.profiles where id=auth.uid() and role in ('admin','super_admin')); $$;

create or replace function public.is_aab_super_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.profiles where id=auth.uid() and role='super_admin'); $$;

alter table public.profiles enable row level security;
alter table public.org_transactions enable row level security;
alter table public.savings_transactions enable row level security;

drop policy if exists "profile self or admin read" on public.profiles;
drop policy if exists "admin manage profiles" on public.profiles;
drop policy if exists "profile self or super admin read" on public.profiles;
create policy "profile self or super admin read" on public.profiles
for select to authenticated using (id=auth.uid() or public.is_aab_super_admin());

create policy "super admin manage profiles" on public.profiles
for all to authenticated using (public.is_aab_super_admin()) with check (public.is_aab_super_admin());

drop policy if exists "admin read organization finance" on public.org_transactions;
drop policy if exists "admin insert organization finance" on public.org_transactions;
drop policy if exists "admin update organization finance" on public.org_transactions;
drop policy if exists "admin delete organization finance" on public.org_transactions;
create policy "all admins read organization finance" on public.org_transactions
for select to authenticated using (public.is_aab_admin());
create policy "all admins insert organization finance" on public.org_transactions
for insert to authenticated with check (public.is_aab_admin() and created_by=auth.uid());
create policy "all admins update organization finance" on public.org_transactions
for update to authenticated using (public.is_aab_admin()) with check (public.is_aab_admin());
create policy "all admins delete organization finance" on public.org_transactions
for delete to authenticated using (public.is_aab_admin());

drop policy if exists "member reads own savings admin reads all" on public.savings_transactions;
drop policy if exists "admin insert savings" on public.savings_transactions;
drop policy if exists "admin update savings" on public.savings_transactions;
drop policy if exists "admin delete savings" on public.savings_transactions;
create policy "admins read own savings super admin reads all" on public.savings_transactions
for select to authenticated using (member_id=auth.uid() or public.is_aab_super_admin());
create policy "admins insert own savings super admin inserts all" on public.savings_transactions
for insert to authenticated with check (
  public.is_aab_admin() and created_by=auth.uid()
  and (member_id=auth.uid() or public.is_aab_super_admin())
);
create policy "super admin update savings" on public.savings_transactions
for update to authenticated using (public.is_aab_super_admin()) with check (public.is_aab_super_admin());
create policy "super admin delete savings" on public.savings_transactions
for delete to authenticated using (public.is_aab_super_admin());

grant usage on schema public to authenticated;
grant select on public.profiles to authenticated;
grant select,insert,update,delete on public.org_transactions to authenticated;
grant select,insert,update,delete on public.savings_transactions to authenticated;
