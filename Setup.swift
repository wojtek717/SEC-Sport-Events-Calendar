import ProjectDescription

let setup = Setup([
    .homebrew(packages: ["mint", "needle"]),
    .mint(),
    .custom(name: "Generating files", meet: ["sh", "Scripts/generate_files.sh"], isMet: ["exit", "-1"]),
  ])
