/*
DEFAULT CHARACTER SET utf8mb4
Sets the default character encoding for the database or table.
utf8mb4 is a full UTF-8 implementation supporting all Unicode characters,
including emojis, special symbols, and characters from all languages.
It uses up to 4 bytes per character for full international text compatibility.

DEFAULT COLLATE utf8mb4_unicode_ci
Defines the default collation (sorting and comparison rules) for the character set.
utf8mb4_unicode_ci means:
- utf8mb4 → uses the utf8mb4 character set
- unicode → follows Unicode standard rules for comparison
- ci      → case-insensitive (e.g., 'A' = 'a')
Ensures consistent sorting and case-insensitive comparisons for multilingual data.

UNICODE CHARACTERS
Unicode assigns a unique code point to every character globally, covering
letters, numbers, symbols, emojis, and scripts from all languages.
It allows consistent storage and display of international text.
Encodings like UTF-8 (used by utf8mb4) store these Unicode characters in databases
and applications reliably.
*/


CREATE DATABASE olist_ecommerce_db
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

USE olist_ecommerce_db;