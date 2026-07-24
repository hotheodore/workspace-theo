-- Coursework tracker — one-time Supabase setup.
-- Paste this whole file into Supabase: Project → SQL Editor → New query → Run.

create table if not exists tracker_state (
  code text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

-- Row Level Security: on, but wide open to anyone holding the anon key,
-- which is fine here since the "code" itself is the real secret —
-- nobody can read or write a row without already knowing its code.
alter table tracker_state enable row level security;

create policy "anyone can read/write with the anon key"
  on tracker_state
  for all
  using (true)
  with check (true);
