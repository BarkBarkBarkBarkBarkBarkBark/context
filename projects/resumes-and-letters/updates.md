# Resumes and Letters: Updates

## 2026-10-17T09:01:46-07:00 | resumes-and-letters:orient-project | Initial orientation

- Established the job-search outcome and orientation-only scope from direct user
  direction; resume edits, catalog integration, and publication remain deferred.
- Inspected active sources, historical materials, the unmerged October update
  bundle, and the skills catalog. Recorded stale/differing education wording,
  missing schema, missing active inventory path, and incomplete GitHub evidence.
- Parsed the catalog and checked skill category/evidence and evidence source
  references. No remote links, experimental outcomes, or historical build claims
  were independently revalidated.
- With user approval, renamed the empty context folder to `resumes-and-letters`;
  added the five standard records, project registry/index, and local checkout map.
- Validation: hub validator passed with 12 projects and 29 tasks; project `next`
  query exposed the intended dependencies; `git diff --check` passed and all
  14 local project-document links resolved. Source worktree status was unchanged.
- Next: on authorization, resolve the catalog contract and source locations,
  then pilot a small evidence-backed skill-to-project mapping.

## 2026-10-17T09:23:21-07:00 | resumes-and-letters:pilot-project-evidence | Source-to-skill mapping

## 2026-10-17T13:42:33-07:00 | resumes-and-letters:prepare-gh-pages-workflow | Deployment intent

- User requested deploying generated resume artifacts to GitHub Pages so the resume and linked evidence are available online.
- Planned next actions: prepare a non-destructive GitHub Actions workflow that builds the resume artifacts in CI, places the chosen HTML/PDF outputs into a site directory, and publishes to the gh-pages branch using a tested action (e.g. peaceiris/actions-gh-pages). The workflow will be documented and require an explicit user token or a reviewed PR to enable publishing.
- Acceptance: workflow file and README instructions added to the repository; the build reproduces locally; publication requires a one-time user-provided token or confirmed repository secret.

## 2026-10-17T13:50:00-07:00 | resumes-and-letters:deploy-workflow-added | Workflow created

- Added GitHub Actions workflow at `.github/workflows/deploy_resume_pages.yml` that runs on push to `main` (automatic) and supports manual dispatch. The workflow:
  - Installs pandoc and a minimal LaTeX toolchain required for the LuaLaTeX build.
  - Installs Python runtime deps and runs `resume/scripts/build_resume.py` for the default `neuroengineering` profile.
  - Selects the most-recent per-run output folder and publishes its contents to the `gh-pages` branch using `peaceiris/actions-gh-pages`.
- Notes and constraints:
  - The workflow uses the standard `GITHUB_TOKEN` for authentication and writes to `gh-pages`; if a different token or a personal deployment token is preferred (for cross-repo or organization settings), the user should create and supply `DEPLOY_TOKEN` in repository secrets and the workflow can be adjusted.
  - LaTeX and TeXLive installs are large; first-run times may be long on CI. If fast lightweight publishing (Markdown/HTML only) is preferred, the workflow can be trimmed to skip the PDF/LuaLaTeX steps.
  - The workflow currently publishes the most-recently produced output folder. If a stable URL is required (e.g., `https://<user>.github.io/resume/`), the workflow can copy files into a predictable folder structure or a specific branch path; indicate preference.
- Next: confirm whether automatic on push to `main` is acceptable (user chose this). If so, enable Pages in the repository settings (it will serve from `gh-pages` branch root) and verify the first deployment after a push.


- User authorized identifying documented skills and adding relevant projects.
  Reviewed six context-linked source projects; added six catalog source/evidence
  pairs and updated 38 existing skill records, including 29 previously
  undocumented skills and two source-supported promotions from reported status.
- Added eight public, commit-pinned GitHub documents after canonical-repository
  visibility checks, retrieval and exact local/remote blob matching. Resolved
  repository redirects to `zlab_sorting_script` and `RTS-mvp`.
- Kept semantic-stream and toolbox local-only, with file SHA256 snapshots and no
  invented GitHub documents. Did not conflate semantic-stream with semantic_neuron.
- Catalog checks passed for reference integrity, document fields/commit anchors,
  unchanged inclusion/visibility/proficiency/resume text, retained prior evidence
  and unchanged unrelated records. Catalog now has 875 skills, 20 evidence records,
  16 sources and 119 nonempty skill statements. `git diff --check` passed.
- Recorded source limitations, including plugin function-name mismatch, skipped
  stream gap markers and synthetic/buffer limitations; no source fixes or runtime
  tests were performed. No resume, letters, website or OR-access document edits.
- Next: confirm personal contributions/inclusion choices; resolve schema/source
  paths before exporter work. Runtime and public-export readiness remain separate.
- Final validation: `ruby scripts/context.rb validate` passed with 12 projects
  and 30 tasks; project `next` query and all six evidence-to-registry IDs passed;
  14 local context links resolved. Removed formatter-introduced trailing spaces
  and reran catalog checks successfully. Source implementation files were not
  edited; temporary mapping/validation files were removed after checking.
