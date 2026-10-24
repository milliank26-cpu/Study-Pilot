-- StudyPilot cloud storage: one private JSON document per authenticated user.
-- Safe to run more than once; does not modify Simple Uget's resources table.
create table if not exists public.studypilot_user_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Compatibility if an earlier setup created planner_data instead of data.
alter table public.studypilot_user_data
  add column if not exists data jsonb not null default '{}'::jsonb;

alter table public.studypilot_user_data enable row level security;

-- Remove policies from earlier versions of this starter SQL to avoid duplicate policies.
drop policy if exists "Users read their own StudyPilot data" on public.studypilot_user_data;
drop policy if exists "Users insert their own StudyPilot data" on public.studypilot_user_data;
drop policy if exists "Users update their own StudyPilot data" on public.studypilot_user_data;
drop policy if exists "Students can read their own StudyPilot data" on public.studypilot_user_data;
drop policy if exists "Students can create their own StudyPilot data" on public.studypilot_user_data;
drop policy if exists "Students can update their own StudyPilot data" on public.studypilot_user_data;

create policy "Users read their own StudyPilot data"
  on public.studypilot_user_data for select
  to authenticated
  using ((select auth.uid()) = user_id);

create policy "Users insert their own StudyPilot data"
  on public.studypilot_user_data for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

create policy "Users update their own StudyPilot data"
  on public.studypilot_user_data for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

revoke all on public.studypilot_user_data from anon;
grant select, insert, update on public.studypilot_user_data to authenticated;
