[//]: # (# check-dependencies-in-pr-action)

[//]: # (A Github action that publish a comment in your PR when it's neccesary to update gradle dependencies)

# Hello world docker action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

## `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

## `time`

The time we greeted you.

## Example usage

uses: actions/hello-world-docker-action@v2
with:
who-to-greet: 'Mona the Octocat'