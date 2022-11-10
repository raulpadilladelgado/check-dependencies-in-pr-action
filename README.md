# Check Dependencies in Pull Request Action

A GitHub action that publish a comment in your PR when it's necessary to update gradle dependencies

## Inputs

## `pull_request_url`

The pull request URL to publish the result

## `github_token`

The project's GitHub token for posting the comment.

## Example usage

```yaml
name: Check Dependencies

on:
  pull_request:
    types: [opened]
jobs:
  dependency_check:
    runs-on: ubuntu-latest
    name: Check dependencies and add a comment in the PR with the result
    steps:
      - name: Checkout project sources
        uses: actions/checkout@v2
      - name: Check Dependencies
        uses: raulpadilladelgado/check-dependencies-in-pr-action@main
        with:
          pull_request_url: ${{ github.event.pull_request.comments_url }}
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

