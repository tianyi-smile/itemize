/// `itemize` version (in *module `adv`*)
#let version = "0.3.0"

/// Resets all resume counter (in *module `adv`*)
///
/// If these records are no longer needed in the document, you can call the `adv.reset-resume()` method to clear this information. One common use case is:
///   ```typst
///   // New enum-before
///   #el.adv.reset-resume()
///   // New enum-here:
///   #el.adv.reset-resume()
///   // New enum-after
///   ```
///   - *Note*: Improper use of `adv.reset-resume()` may break the `resuming enum` functionality (*not* recommended to use).
#let reset-resume() = {}
