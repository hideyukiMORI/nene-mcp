# Documentation and Policy Self-Review

Use for policy docs, workflow, ADRs, README, AGENTS.md, and `.cursor/rules/`.

Source policies:

- `docs/development/language-policy.md`
- `docs/development/self-review.md`
- `docs/development/adr.md`
- `docs/workflow.md`

## Checklist

- [ ] Source-of-truth updated in `docs/`—not only Cursor rules or chat.
- [ ] Public text is English (`language-policy.md`).
- [ ] Links to sibling repos (NeNe, NENE2, nene-mcp integrators) are correct.
- [ ] No duplication of full policy text across many files; link instead.
- [ ] Issue and PR references included where useful.
- [ ] New durable rules are concrete enough for humans and AI agents.
- [ ] ADR created or updated for major architecture / contract decisions.
- [ ] `docs/README.md` index updated when adding new doc files.
- [ ] Checklist files link to policies instead of copying them.

## Verification

- Manual read-through of rendered Markdown.
- Confirm no Japanese crept into public docs unless explicitly out of scope.
