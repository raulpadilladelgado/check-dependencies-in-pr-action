# Check Dependencies in Pull Request Action

A GitHub action that publish a comment in your PR when it's necessary to update gradle dependencies

## Outputs

## `outdated`

Dependencies with newer available releases

## Example usage

```yaml
name: Check Dependencies

on: pull_request

jobs:
  dependency_check_in_pr_job:
  runs-on: ubuntu-latest
  name: A job to say hello
  steps:
    - name: Check Dependencies
      id: dependency_check
      uses: raulpadilladelgado/check-dependencies-in-pr-action@main
    - name: Publish Comment
      uses: mshick/add-pr-comment@v1
      with:
        message: |
          **Dependencies with newer available releases:**
          ${{ steps.dependency_check.outputs.outdated }}
repo-token: ${{ secrets.GITHUB_TOKEN }}
repo-token-user-login: 'github-actions[bot]'
```

