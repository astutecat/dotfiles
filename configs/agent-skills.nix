{
  pkgs,
  ...
}:

let
  # https://github.com/mattpocock/skills — the skills.sh source.
  # Update by bumping `rev` and refreshing `hash`
  # (e.g. `nix flake prefetch --json github:mattpocock/skills`).
  pocock-skills = pkgs.fetchFromGitHub {
    owner = "mattpocock";
    repo = "skills";
    rev = "3cca18b368ae95cdbdebbff572ccafa662551015";
    hash = "sha256-dF5i37jHnqfcXD1IRSVzSSm/pfCYSUmOsEhhs5Zx340=";
  };

  # Equivalent of `npx skills add <repo> --skill <name>`: extract one skill
  # folder (e.g. skills/<category>/<name>) so it can be linked flat into
  # ~/.agents/skills — the shared location read by both Zed and opencode.
  # Zed only discovers top-level skill dirs, so keep the target layout flat.
  mkSkill =
    {
      repo,
      category,
      name,
    }:
    pkgs.runCommand "agent-skill-${name}" { } ''
      cp -r "${repo}/skills/${category}/${name}" "$out"
    '';
  skills = {
    code-review = "engineering";
    codebase-design = "engineering";
    implement = "engineering";
    improve-codebase-architecture = "engineering";
    research = "engineering";
    resolving-merge-conflicts = "engineering";
    tdd = "engineering";
    triage = "engineering";
    setup-matt-pocock-skills = "engineering";
    grill-me = "productivity";
    grilling = "productivity";
  };
in
{
  home.file = builtins.mapAttrs (name: category: {
    target = ".agents/skills/${name}";
    source = mkSkill {
      inherit name category;
      repo = pocock-skills;
    };
  }) skills;
}
