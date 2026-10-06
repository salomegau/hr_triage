# Group 03 HR Service Request Triage

Tarek ELOUARET  |  15 hour project  |  Two students maximum  |  English

## 1 Project title

HR Service Request Triage

## 2 Business and technical context

An HR service desk needs to organize routine employee questions. Route an HR request using synthetic data without making employment or payment decisions. Start from the supplied working FastAPI and Streamlit application; extend it rather than rebuilding it.

## 3 Learning objectives

- Integrate a local model through a provider contract and validate its JSON output.
- Collaborate through reviewed Git changes and prove critical behaviour with tests.
- Build a Jenkins delivery pipeline and deploy its image with local Terraform resources.

## 4 Functional requirements

- Accept a subject of 3 to 100 characters and request text of 10 to 4000 characters. Reject invalid input.
- Return summary and next_action fields of 10 to 240 characters, one allowed category, and a low, medium or high priority.
- Display the analysis in Streamlit, preserve the last results in SQLite, and always mark requires_review as true.
- Use the local model to propose routing. Never claim that a real action has occurred.
- Classify each supplied example into its expected category in mock mode; document measured quality in local mode.

| Category | Example user request |
| --- | --- |
| leave | Holiday request status |
| payroll | Payslip access issue |
| onboarding | New starter checklist |

Your fixture file contains six requests, two for each category. Add one original request and one adversarial input. Ambiguous requests require a reviewer; do not invent external facts.

## 5 Technical requirements

Use VS Code, Python, FastAPI, Pydantic, Streamlit, SQLite, httpx and pytest. Keep the existing summary CLI and provider boundary usable. Add an AnalysisProvider for the structured feature. Use LM Studio locally and a deterministic mock for CI. Jenkins runs on a prepared Linux agent; Docker runs Linux containers. Terraform uses the pinned kreuzwerker/docker provider. No cloud account, vector database or Kubernetes is required.

## 6 Architecture

| Component | Responsibility |
| --- | --- |
| Streamlit UI | Send the request to the API and show a reviewable result. |
| FastAPI and AnalysisService | Validate the request and apply the scenario contract. |
| Provider adapter | Call LM Studio or provide mock behaviour through the same interface. |
| SQLite | Store validated result records. |
| Jenkins and Docker | Test the Git revision and build its image. |
| Terraform | Own the group network, data volume and API and UI containers. |

## 7 Tasks

- Copy 05-common-starter into your repository. Record g03 in group.txt. Add scenarios/g03.json with your three categories and routing instructions.
- Complete the local analysis adapter, scenario mock and prompt. Extend the UI only where the assigned workflow needs it.
- Write failure tests and create your Jenkinsfile. Obtain a green run and deliberately demonstrate one failed-test run.
- Write Dockerfile and .dockerignore. Deploy the successful CI image through Terraform, then prove no-change planning and cleanup.

## 8 Expected implementation

Use /api/analyze, /api/history and /health. Keep provider code out of the UI and business service. Read configuration from .env locally and environment variables in containers. Set a finite timeout and output token limit. Map unavailable inference to a controlled API error and reject invalid JSON or an unknown category. Save only validated analysis records. Do not log credentials or full request content.

Follow the common four-session schedule in the overview. Your UI, endpoint contract and delivery resources must remain comparable to the other groups.

## 9 Git requirements

- Both students contribute code and review the other student. Use feature branches and at least two reviewed pull requests.
- Use meaningful commits describing an increment or fix. Preserve the deliberate failure and correction as separate commits.
- Ignore local environments, .env, databases, reports, Terraform state and private token files. Commit the provider lock file and .env.example.
- Record individual contributions and substantial coding-assistant use in CONTRIBUTIONS.md and AI_USAGE.md.

## 10 Testing requirements

- Keep the working baseline tests. Add six scenario fixtures, input validation, one fake-transport adapter test, a timeout test and malformed-output or unknown-category tests.
- CI must run without LM Studio, GPU or API tokens. Test the request payload and parser using httpx.MockTransport.
- Test the API error code and confirm failed inference does not add a successful history record.
- Run the six fixtures against LM Studio separately. Record validity, category agreement and observed latency, including failures. Do not assert exact live wording.

## 11 Jenkins requirements

- Create a Pipeline from SCM job using Jenkinsfile and the prepared ai-lab agent. Configure SCM polling or an approved webhook.
- Install dependencies, run pytest and publish JUnit XML even when a test fails. Validate Terraform before building the image.
- Build a group-specific, immutable-per-build image tag only after tests succeed. Run a container smoke test in mock mode and archive the report and image tag.
- Prove one commit triggers CI, a failing test prevents image creation, and the corrected commit passes. A manually typed test command alone does not satisfy CI.

The default lab uses the same Docker daemon for Jenkins and Terraform. If your agent is remote, transfer the green image with docker save and docker load before local deployment. Record this handoff. Jenkins does not call your laptop LLM.

## 12 Docker requirements

Create a runtime image with pinned dependencies, the package, scenario policy and UI. Run as an unprivileged user and allow SQLite writes under /data. Exclude .env, tests, local databases and Terraform state from the image. The API listens on 0.0.0.0 inside its container. The UI and API can use the same image with different startup commands. LM Studio remains a separate host service.

## 13 Terraform requirements

Define variables for group_id, image_name, Docker endpoint and model configuration. Terraform manages one Docker image reference, a group network, a named data volume and two application containers. Publish API on 127.0.0.1:8003 and UI on 127.0.0.1:8503. Connect UI to the API service name. Connect the API to the actual LM Studio host address. Create resources with init, plan and apply; show a second plan with no changes; then destroy only your resources. Destroy removes the teaching data volume. Avoid application Compose ownership of these same resources.

## 14 Expected final result

At your UI URL, submit a request in the leave category and display a validated local-model result. Stop LM Studio and show a controlled error. Show a green CI image tag, the Terraform-managed containers and a no-change plan. A model disagreement is acceptable when you report it honestly and maintain output validation.

## 15 Deliverables

Submit the repository, README, two ADRs, tests, six-case evaluation, Jenkinsfile, CI success and failure evidence, Dockerfile, Terraform files and lock file, plan/output evidence, CONTRIBUTIONS.md and AI_USAGE.md. The second student must reproduce the project from a clean clone.

## 16 Evaluation criteria

The shared rubric totals 100 points: functionality 15, LM Studio 10, architecture 10, Git 10, tests 15, Jenkins 15, Docker 10, Terraform 10 and documentation 5. Each student explains a contribution during the final defense. Evidence quality and reproducibility determine the score.

## 17 Stretch goals

After all required gates pass, add one bounded retry for a transient failure, compare two prompt versions, or add a human approval state. Document the test and tradeoff. Bonus work earns no credit for a missing required gate.

## 18 README template

Use 02-readme-templates/README_g03.md. Fill its objective, architecture, installation, LM Studio, run, tests, Git, Jenkins, Docker, Terraform, evidence, troubleshooting and limitations sections. Replace all bracketed prompts with your own verified information.