# Nofile.ng

Nofile.ng is a simple file transfer app built with Ruby on Rails. A clone of http://nofile.io

## Tech Stack
Nofile.ng is built using:
- Ruby on Rails
- PostgreSQL

## Get started
- Ensure you have Ruby, Ruby on Rails and PostgreSQL installed on your machine.
- Clone this repository:
```sh
$ git@github.com:jattoabdul/nofile-clone.git
```
- Change into the `nofile-clone` directory and checkout to the `staging` branch:
```sh
$ cd nofile-clone
```
- Install all dependencies:
```sh
$ bundle install
```
- Create an `.env` file in the `root` directory and copy the contents of `.env.sample` into it. Replace the details there with your own details.
- Run Database setup
```sh
$ rails db:setup
```
- Start the development server:
```sh
$ rails server
```
You're set to consume any endpoint at `http://localhost:3000/`.

## How to contribute
- Fork this repository.
- Clone it.
- Create your feature branch on your local machine with `git checkout -b your-feature-branch`
- Push your changes to your remote branch with `git push origin your-feature-branch`
- Open a pull request against the develop branch, and describe how your feature works

Want to see new features? Open an issue.
