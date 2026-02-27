-- Admin users table for Daily Calorie Tracker V5
-- Run in Supabase SQL Editor.

create table if not exists public.dct_admin_users (
  email text primary key,
  created_at timestamptz not null default now()
);

alter table public.dct_admin_users enable row level security;

drop policy if exists "admin_users_select_root" on public.dct_admin_users;
create policy "admin_users_select_root"
on public.dct_admin_users
for select
using (lower(auth.email()) = 'georgepavlov@live.com');

drop policy if exists "admin_users_insert_root" on public.dct_admin_users;
create policy "admin_users_insert_root"
on public.dct_admin_users
for insert
with check (lower(auth.email()) = 'georgepavlov@live.com');

drop policy if exists "admin_users_delete_root" on public.dct_admin_users;
create policy "admin_users_delete_root"
on public.dct_admin_users
for delete
using (lower(auth.email()) = 'georgepavlov@live.com');

insert into public.dct_admin_users (email)
values ('georgepavlov@live.com')
on conflict (email) do nothing;
