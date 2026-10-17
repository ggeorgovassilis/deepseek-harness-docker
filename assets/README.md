# Assets

All three screenshots were captured on **2026-10-17**, using the actual **DSH 0.2.1-rc.2** Web UI in **Light** mode at **1440 × 900** pixels. A headless Playwright browser captured a clean, temporary market-variant container; the user's existing deployment, model configuration, workspaces, and sessions were not used or changed.

| Asset | Image / component | View |
| --- | --- | --- |
| `deepseek-harness-web.png` | `runzhliu/deepseek-harness:0.2.1-rc.2-r1-market.1` | New-session page with an empty `demo-project` workspace, Plugins, and Automation tasks. The core Web UI is shared with the default image. |
| `browser-desktop-webui.png` | Same market image; `@runzhliu/dsh-browser-desktop@0.1.5` | Real container Chromium opening the public official `dsh-v0.2.1-rc.2` GitHub Release inside the movable, resizable desktop panel. |
| `plugin-market-webui.png` | Same market image; `dshmarket@1.66.9` | Settings → Plugin market → Discover. This optional community market is not included in the default image. |

## Capture notes

- Use disposable containers with temporary DSH state and an empty demonstration workspace; do not reuse personal volumes or provider credentials.
- Accept the first-run notice, defer provider setup, select Light in Settings, and open the empty `demo-project` workspace through the normal UI.
- For the desktop view, navigate the container's Chromium to the public upstream RC2 Release page. Move and resize the overlay with its normal controls; both Harness and the GitHub page use a light theme.
- For the market view, wait for the catalog and compatibility indicators to load. Do not install a plugin merely to take the screenshot. Catalog entries, metrics, and compatibility indicators are a dated snapshot, not an endorsement or an installation test.
- Capture only the page viewport, excluding the host browser's address bar and temporary launch token. Inspect each PNG for secrets, internal endpoints, private paths, and UI errors before replacing the README assets.

No model was configured or called; the model selector is empty. No API credentials, personal session content, model responses, or internal service endpoints are present. These are unaltered application screenshots, not generated mockups.
