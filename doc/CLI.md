# CLI

This document defines the command-line interface of **codebase-snapshot**.

The CLI is responsible only for **orchestration**.

All core logic must remain inside the `core/` modules.

---

# Main Command

The primary command of the tool is:

bin/snapshot

Future installations may expose it simply as:

snapshot

---

# Example Usage

Example command:

bin/snapshot --target /path/to/project --label initial

Expected result:

snapshots/YYYY-MM-DD/vX.Y.Z/01_initial/

---

# CLI Responsibilities

The CLI should:

- parse user arguments
- validate inputs
- resolve the target repository
- read the tool version
- normalize snapshot naming
- call the appropriate core modules
- write execution logs
- return clear exit codes

The CLI must remain minimal.

---

# CLI Options (planned)

The CLI is expected to support options such as:

--target      path to the repository to snapshot  
--label       human-readable snapshot label  
--config      optional configuration file  
--output      optional output root directory  
--help        display usage information  
--version     display tool version  

The exact interface may evolve but must remain simple.

---

# Exit Codes

The CLI should follow standard exit conventions:

0   success  
1   general error  
2   invalid arguments  

Errors must always produce explicit messages.

---

# Logging

Execution logs should be written to:

logs/

Logs should remain:

- explicit
- readable
- deterministic when possible

---

# Future Commands

Future versions may introduce additional commands such as:

snapshot list  
snapshot inspect  
snapshot diff  
snapshot doctor  

These commands are not yet implemented but may appear in later versions.
