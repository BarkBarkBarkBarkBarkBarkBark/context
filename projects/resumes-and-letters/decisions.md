# Resumes and Letters: Decisions

## resumes-and-letters:D001 | 2026-10-17 | Superseded

- Decision: Treat finding a neuroengineering job as the primary outcome; complete
  orientation/context now and defer resume rewrites and readable document work.
- Why: Explicit user direction distinguishes the goal from its document tooling.
- Alternatives: Start by rewriting applications or applying the saved update;
  neither is the present request.
- Revisit when: The user authorizes a specific application or document update.
- Supersedes: none.
- Superseded by: D004 for the current work scope; the employment goal is retained.

## resumes-and-letters:D002 | 2026-10-17 | Accepted

- Decision: Use stable hub ID and folder `resumes-and-letters`; the source
  repository remains named `resumes_and_letters`.
- Why: The user explicitly approved renaming the empty context folder to meet the
  existing kebab-case registry/validator contract.
- Alternatives: Keep the underscore folder unregistered; declined by the user.
- Revisit when: The shared hub changes its identity contract.
- Supersedes: none.

## resumes-and-letters:D003 | 2026-10-17 | Accepted

- Decision: Use `neuroengineering_skills.json` as the intended future skills and
  GitHub-example source, without claiming it already drives generated outputs.
- Why: Explicit user direction; current source inspection shows YAML-based
  generators and the catalog already carries evidence and visibility controls.
- Alternatives: Immediately replace active YAML or build a separate competing
  skills inventory; unnecessary before agreeing on the integration contract.
- Revisit when: A concrete integration/export design is authorized.
- Supersedes: none.

## resumes-and-letters:D004 | 2026-10-17 | Accepted

- Decision: Extend orientation into the user-requested source-to-skill evidence
  mapping using existing catalog structures; keep application/export work deferred.
- Why: The follow-up explicitly asks for skills documented by context repositories
  and relevant projects. Missing schema/inventory paths do not prevent bounded
  source annotations with integrity checks, but remain unresolved exporter inputs.
- Alternatives: Block all evidence work on schema design, or automatically rewrite
  the resume; neither addresses the requested source mapping at its actual scope.
- Revisit when: An exporter or application update is requested.
- Supersedes: D001's orientation-only scope, not its primary job-search outcome.

## resumes-and-letters:D005 | 2026-10-17 | Accepted

- Decision: Preserve all inclusion/visibility flags while attaching source
  evidence. Use canonical, exact-commit GitHub links for verified public files
  and SHA256-identified source snapshots without public links for local-only work.
- Why: Code existence supports implementation scope, not independent authorship,
  proficiency, clinical effectiveness or publication consent.
- Alternatives: Fabricate GitHub links from similarly named repositories, promote
  historical test summaries to fresh validation, or enable every mapped skill
  for public export; none is supported by this review.
- Revisit when: Personal contribution/inclusion is confirmed, new tests run, or
  local projects are intentionally published.
- Supersedes: none.

## resumes-and-letters:D006 | 2026-10-17 | Accepted

- Decision: Support a user-authorized publication path to GitHub Pages for
  selected, reviewed resume outputs when the user explicitly requests deployment.
- Why: The user has requested online availability of generated artifacts; a
  reproducible CI workflow (GitHub Actions) that builds and publishes outputs to
  gh-pages balances reproducibility and auditability while preserving the
  catalog's evidence controls.
- Constraints: Publication is only for outputs whose evidence records are
  recruiter-visible and use commit-pinned public artifacts. Local-only evidence
  remains excluded from public pages unless the user explicitly approves
  publication and provides the necessary assets/consent.
- Alternatives: Host artifacts privately (S3, Netlify with preview links), or
  create a PR with built artifacts for manual review prior to publishing.
- Revisit when: The user requests a different hosting target or revokes
  publication consent.
- Supersedes: none.
