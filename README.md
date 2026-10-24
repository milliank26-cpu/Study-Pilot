# StudyPilot — Adaptive Academic Revision Planner

StudyPilot is a browser-based academic revision planner. It can run locally without an account, or sync a signed-in user's data across devices through Supabase after you configure a Supabase project.

## What it can do

- Organise concepts by subject, topic, subtopic and learning objective.
- Track first learning, retrieval practice, assessment results, assistance, confidence, marks and reflections.
- Estimate mastery and review timing from the evidence you log.
- Generate an adaptive timetable from today's date, your availability, commitments, goals, exam deadlines and chosen planning strategy.
- Use a rolling planning window from 1 to 365 days. The default is 14 days. Dates are calculated from the current local date rather than being fixed to a specific October/November range; the plan refreshes when the date changes while the page is open and on subsequent loads.
- Keep academic revision capacity separate from the informational project-work budget.
- Export/import JSON backups and export schedule, history and report CSV files.
- Optionally use Supabase Auth and a private cloud JSON record to sync your planner between devices.

## Important limits

- It does not magically know your syllabus, marks, assignments, or progress. Enter these or import them; recommendations are only as good as the information provided.
- Mastery, priority and review intervals are transparent heuristics, not validated predictions or guarantees of exam results.
- The 365-day setting is a rolling planning horizon, not a promise that the app will pre-generate a perfect ten-year calendar. You can keep using it year after year and add future exam dates as they become known.
- Without Supabase configured and a user signed in, data stays in that browser's local storage. Browser clearing can erase local-only data; export backups regularly.
- Cloud sync requires your own Supabase project and a hosted copy of this site. This package does not create the Supabase account or publish the site for you.
- Cloud data syncs as one private record per account. Each student has a separate row protected by row-level security. The current planner is personal per account and does not support simultaneous collaborative editing.

## Run locally

Open `index.html` in a modern browser. For the most consistent behavior, use a local server from this directory, for example:

```bash
python -m http.server 8000
```

Then open `http://localhost:8000`.

## Enable Supabase cloud sync

1. Create a project at [Supabase](https://supabase.com/).
2. In the Supabase dashboard, open **SQL Editor** and run `supabase-setup.sql`. If you already created the `studypilot_user_data` table using the guided setup, you do not need to rerun it unless you are applying the updated policy setup; export/backup important data before changing schema.
3. In **Authentication → Providers**, ensure Email/password authentication is enabled. Configure email confirmation to suit your security needs.
4. In **Project Settings → API** (or the API Keys page), copy the Project URL and the public publishable key / legacy `anon` key. **Never put a `service_role` or secret key in browser code.**
5. Host this folder on an HTTPS static host (for example, Netlify, Vercel or GitHub Pages). The Supabase browser SDK is loaded from a CDN, so the page needs internet access for cloud features.
6. Open the hosted site, go to **Settings & backup → Cloud sync**, enter the Project URL and public key, and save the settings.
7. Create an account or sign in. If email confirmation is enabled, follow the verification link first. The first sign-in asks whether to upload this device's local data if no cloud record exists. If cloud data already exists, the app asks whether to load the cloud copy or keep this device's data and explicitly confirm an upload over the cloud copy. Read those prompts carefully to avoid overwriting the copy you need.
8. On another device, open the same hosted URL, enter the same Supabase project URL/key, and sign into the same account.

The SQL enables row-level security and limits each authenticated user to their own row. Treat the public anon/publishable key as public; the row-level security policies, not key secrecy, protect the stored data. Do not disable RLS or expose a service-role key.

## First setup

1. Edit the student profile and subjects.
2. Add concepts individually, paste structured concepts, or import CSV.
3. Set weekday academic availability and date-specific exceptions.
4. Add real exam deadlines and scope.
5. Select a planning strategy and horizon on **Timetable**, then recalculate.
6. Log outcomes after learning/retrieval/practice so the planner can adapt.
7. Export a JSON backup occasionally even when cloud sync is enabled.

## Research foundations

- Dunlosky et al. (2013), [Improving Students' Learning With Effective Learning Techniques](https://doi.org/10.1177/1529100612453266)
- Cepeda et al. (2006), [Distributed Practice in Verbal Recall Tasks](https://doi.org/10.1037/0033-2909.132.3.354)
- Donoghue & Hattie (2021), [A Meta-Analysis of Ten Learning Techniques](https://doi.org/10.3389/feduc.2021.581216)
- Institute of Education Sciences, [Organizing Instruction and Study to Improve Student Learning](https://ies.ed.gov/ncee/wwc/PracticeGuide/1)
