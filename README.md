<!-- SPDX-License-Identifier: Apache-2.0 OR MIT -->
<h1 align="center">
  Platform Devcontainer Base Image
</h1>

<p align="justify">
  The base image used by every plataform-cortex service repo's <code>.devcontainer/</code>.
</p>
<p align="justify">
  Pinning the toolchain in this image lets engineers stay out of the business of managing <code>nvm</code>, <code>pulumictl</code>, <code>tilt</code>, <code>kind</code>, <code>kubectl</code>, and <code>opa</code> versions on their laptops.
</p>

<p align="center">
  <a href="https://scorecard.dev/viewer/?uri=github.com/Platform-Cortex/devcontainers">
    <img src="https://img.shields.io/ossf-scorecard/github.com/Platform-Cortex/devcontainers?style=for-the-badge&label=OpenSSF%20Scorecard&logo=openssf" alt="OpenSSF Scorecard"/>
  </a>
</p>

## Purpose

A single, reproducible developer environment. New hires open a service repo in VS Code, click
"Reopen in Container," and inherit the full platform toolchain — same versions as CI, same versions
as the rest of the team, no manual installs.

The image is also the substrate for `plataform-cortex-dev` (see `@plataform-cortex/platform-dev-runner`): when an
engineer runs `bun run dev` inside a service repo's devcontainer, all the orchestration tools
(`kind`, `kubectl`, `tilt`, `pulumi`, `bun`) are already on `PATH`.

## Pinned versions

All versions are `ARG` defaults at the top of `Dockerfile`:

| Tool    | Version |
| ------- | ------- |
| Bun     | 1.3.10  |
| Pulumi  | 3.142.0 |
| kind    | 0.24.0  |
| kubectl | 1.30.0  |
| Tilt    | 0.33.18 |
| OPA     | 1.16.1  |
| Node    | 24      |

`.nvmrc` at the repo root is pinned to `24` to match.

## Nightly build (GitHub Actions)

A scheduled workflow (`.github/workflows/devcontainer-nightly.yml`, _to be added in a future commit_)
rebuilds the image every night at 03:00 UTC and pushes to
`ghcr.io/plataform-cortex/platform-devcontainer:latest`. The workflow:

1. Checks out the repo.
2. Logs into GHCR via OIDC.
3. Runs `docker buildx build platform-foundation/devcontainer/ --tag ghcr.io/plataform-cortex/platform-devcontainer:latest --push`.
4. Tags the same digest with the date (`:2026-05-02`) for rollback.

Service repos pin to `:latest` for active development and bump to a date tag for hotfixes that
must reproduce a known-good environment.

## Testing locally

```bash
docker build platform-foundation/devcontainer/
```

Once built, smoke-test by running the image and asking each tool for its version:

```bash
docker run --rm $(docker build -q platform-foundation/devcontainer/) \
  bash -lc 'bun --version && pulumi version && kind version && kubectl version --client && tilt version && opa version'
```

## Updating versions

1. Bump the relevant `ARG` line in `Dockerfile`.
2. Open a PR — CI verifies the image still builds.
3. On merge, the nightly workflow picks up the new pin on the next 03:00 UTC run; ad-hoc rebuilds
   can be triggered via `workflow_dispatch`.
4. Service repos inherit the bump automatically because they reference `:latest`.

When bumping Bun, also bump `engines.bun` in every `package.json` under `platform-modules/` and
update `bunfig.toml` if the new release changes any of the [coverage quirks](../../platform-modules/CLAUDE.md).
