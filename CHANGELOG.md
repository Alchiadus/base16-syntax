1.3.0
=====

## Bug Fixes
- Fixed attribution. Added respective authors to each scheme's LESS file.

1.2.0
=====

## Bug Fixes
- Fixed an incorrect selector.

1.1.0
=====

## Bug Fixes
- Fixed a deprecated call.

1.0.1
=====

## Bug Fixes
- Fixed an issue causing apm not to upgrade to 1.0.0

1.0.0
=====

This update brings full support for Atom's 1.0 API.

It may be required to empty Atom's less compile cache by removing the files inside `~/.atom/compile-cache/less` and restarting Atom.

## New Features
- Shadow DOM support
- New themes:
  - Apathy
  - Bright
  - Colors
  - Flat
  - Harmonic
  - Hopscotch
  - Pop
  - Summerfruit

## Bug Fixes
- Fixed an issue where the wrap guide was incorrectly styled or not styled at all.
- Fixed an issue where markup headings were not properly styled.

0.2.1
=====

## Bug Fixes
- Fixed a mistake in the required Atom version.

0.2.0
=====

## New Features
- The configuration settings for schemes and styles have been updated to make use of the drop down functionality introduced in Atom 0.134.0.

## Bug Fixes
- Fixed an issue where a light theme could not be activated after a dark theme had been activated and vise versa.

0.1.2
=====

## Bug Fixes
- Fixed an issue on Ubuntu where less stylesheets could not be compiled.

0.1.1
=====

## Bug Fixes
- Fixed preview link in README.

0.1.0
=====

## New Features
- Support for all Base16 color schemes and styles.
- 'Smart' defaults: dark style for dark UI themes and light style for light UI themes.
- Preview of each selected theme on all open files while browsing through the list of available themes.
