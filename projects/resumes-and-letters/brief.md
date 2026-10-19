# Resumes and Letters

Project ID: `resumes-and-letters`

## Outcome

Help Marco Del Fava find a neuroengineering job by connecting relevant experience
and skills to concrete, inspectable project evidence and targeted applications.
Resume generation and human-readable Markdown are supporting tools, not the
primary outcome.

## Scope And Non-Goals

Initial orientation is complete. The October 17 follow-up authorizes identifying
skills in context-linked source projects and attaching relevant project evidence
to the existing catalog. It does not authorize resume edits, applying the saved
update patch, website publication, or generator integration.

The catalog now contains an initial source-reviewed mapping. Future work: confirm
personal contributions and inclusion choices, fill remaining evidence gaps, then
use reviewed evidence to improve application materials. Human-readable documents
can be developed in the source checkout's `markdown/` directory later.

## Durable Rules

- Current user direction governs priorities. Do not turn context or evidence
  maintenance into an unsolicited resume rewrite or broad new portfolio project.
- Treat the catalog as an extensible inventory, not a claim that Marco possesses
  every listed skill or must meet every listed requirement.
- Preserve the catalog's distinction between unknown, reported, planned,
  exposure, in-progress, prototype, implemented, validated, and production work.
  Source review establishes code and scope, not runtime or clinical performance.
- Respect explicit inclusion and visibility controls. The catalog requires a
  nonempty skill statement, evidence IDs, an eligible status, and
  `resume_include: true`; public export additionally requires recruiter visibility
  and a public GitHub document. Do not automatically promote related skills.
- Record personal contribution, source/revision, verification, and limitations
  before converting project features into employer-facing accomplishments.
  An unchecked URL or stored visibility flag is not a fresh link verification.
- Keep clinical data, recordings, credentials, and private operational details out
  of this hub and public evidence. Use approved synthetic/de-identified examples
  or permitted aggregate descriptions.
- Keep active sources, historical applications, and the unmerged update bundle
  distinct. Resolve factual differences before choosing application wording.
- Preserve formal roles and scope: volunteer research is not a new paid title;
  access preparation is not completed OR participation; a prototype is not
  validated live acquisition, a production decoder, or a hard real-time guarantee.

## Sources And Entry Points

Repository: [resumes_and_letters](https://github.com/BarkBarkBarkBarkBarkBarkBark/resumes_and_letters).
Resolve the checkout through `locations.yaml` using this project's stable ID.
The relative links below point to the current sibling checkout; use the local
locations map if either checkout moves.

| Source | Role |
| --- | --- |
| [Source README](../../../resumes_and_letters/README.md) | Existing resume-as-code workflow; not the whole job-search mission. |
| [Skills catalog](../../../resumes_and_letters/neuroengineering_skills.json) | Skills/evidence inventory with context-project source mappings; not currently consumed by the generators. |
| [Active resume YAML](../../../resumes_and_letters/resume/data/base_resume.yaml) | Current generator input, not independent verification of its claims. |
| [Active role profiles](../../../resumes_and_letters/resume/data/role_profiles.yaml) | Filtering/ordering for current application variants. |
| [Letter snippets](../../../resumes_and_letters/resume/data/cover_letter_snippets.yaml) | Reusable application paragraphs. |
| [Saved update bundle](../../../resumes_and_letters/documents/neuroengineering-update-2026-10-17/README.md) | Proposed October update, patch, and mirrored files; not merged into active sources. |
| [Bundled experience inventory](../../../resumes_and_letters/documents/neuroengineering-update-2026-10-17/changed_files/resume/career/experience_inventory.md) | More recent reported experience, goals, measurements, and claim boundaries. |
| [Bundled role strategy](../../../resumes_and_letters/documents/neuroengineering-update-2026-10-17/changed_files/resume/career/target_roles.md) | Prior role-fit judgments and preferences to reconfirm, not current job availability. |
| [Historical applications](<../../../resumes_and_letters/003 - CV - Resume/>) | Earlier resumes, cover letters, and academic statements in Markdown/DOCX. |
| [Markdown workspace](../../../resumes_and_letters/markdown/) | Future human-readable supporting documents; OR-access file is currently empty. |

The bundle suggests research/scientific software, neural data, and acquisition/
test roles as near-term families, with real-time BCI and embedded DSP as more
selective/stretch directions. This is prior planning, not newly confirmed user
selection. Reconfirm compensation, location, schedule/student compatibility,
travel, and animal-work constraints before filtering actual jobs.

Related hub projects are potential evidence sources, not required dependencies
or proof of experience. Read their state and source only when evaluating a
specific skill. Catalog evidence `project_id` values belong to the catalog's own
namespace; do not assume they are registered hub IDs.

## Completion

Orientation is complete when a new session can find the active materials,
understand the job-search goal and evidence rules, distinguish unmerged proposals,
and identify one executable next action without modifying application content.
The broader employment outcome remains open.
