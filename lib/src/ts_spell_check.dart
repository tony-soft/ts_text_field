import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SpellCheckResults, SpellCheckService, SuggestionSpan, TextEditingValue;

import 'ts_editable_text.dart' show TsEditableTextContextMenuBuilder;

/// Controls how spell check is performed for text input.
///
/// This configuration determines the [SpellCheckService] used to fetch the
/// [List<SuggestionSpan>] spell check results and the [TextStyle] used to
/// mark misspelled words within text input.
@immutable
class TsSpellCheckConfiguration {
  /// Creates a configuration that specifies the service and suggestions handler
  /// for spell check.
  const TsSpellCheckConfiguration({
    this.spellCheckService,
    this.misspelledSelectionColor,
    this.misspelledTextStyle,
    this.spellCheckSuggestionsToolbarBuilder,
  }) : _spellCheckEnabled = true;

  /// Creates a configuration that disables spell check.
  const TsSpellCheckConfiguration.disabled()
      :  _spellCheckEnabled = false,
        spellCheckService = null,
        spellCheckSuggestionsToolbarBuilder = null,
        misspelledTextStyle = null,
        misspelledSelectionColor = null;

  /// The service used to fetch spell check results for text input.
  final SpellCheckService? spellCheckService;

  /// The color the paint the selection highlight when spell check is showing
  /// suggestions for a misspelled word.
  ///
  /// For example, on iOS, the selection appears red while the spell check menu
  /// is showing.
  final Color? misspelledSelectionColor;

  /// Style used to indicate misspelled words.
  ///
  /// This is nullable to allow style-specific wrappers of [EditableText]
  /// to infer this, but this must be specified if this configuration is
  /// provided directly to [EditableText] or its construction will fail with an
  /// assertion error.
  final TextStyle? misspelledTextStyle;

  /// Builds the toolbar used to display spell check suggestions for misspelled
  /// words.
  final TsEditableTextContextMenuBuilder? spellCheckSuggestionsToolbarBuilder;

  final bool _spellCheckEnabled;

  /// Whether or not the configuration should enable or disable spell check.
  bool get spellCheckEnabled => _spellCheckEnabled;

  /// Returns a copy of the current [SpellCheckConfiguration] instance with
  /// specified overrides.
  TsSpellCheckConfiguration copyWith({
    SpellCheckService? spellCheckService,
    Color? misspelledSelectionColor,
    TextStyle? misspelledTextStyle,
    TsEditableTextContextMenuBuilder? spellCheckSuggestionsToolbarBuilder}) {
    if (!_spellCheckEnabled) {
      // A new configuration should be constructed to enable spell check.
      return const TsSpellCheckConfiguration.disabled();
    }

    return TsSpellCheckConfiguration(
      spellCheckService: spellCheckService ?? this.spellCheckService,
      misspelledSelectionColor: misspelledSelectionColor ?? this.misspelledSelectionColor,
      misspelledTextStyle: misspelledTextStyle ?? this.misspelledTextStyle,
      spellCheckSuggestionsToolbarBuilder : spellCheckSuggestionsToolbarBuilder ?? this.spellCheckSuggestionsToolbarBuilder,
    );
  }

  @override
  String toString() {
    return '''
  spell check enabled   : $_spellCheckEnabled
  spell check service   : $spellCheckService
  misspelled text style : $misspelledTextStyle
  spell check suggestions toolbar builder: $spellCheckSuggestionsToolbarBuilder
'''
        .trim();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is TsSpellCheckConfiguration
        && other.spellCheckService == spellCheckService
        && other.misspelledTextStyle == misspelledTextStyle
        && other.spellCheckSuggestionsToolbarBuilder == spellCheckSuggestionsToolbarBuilder
        && other._spellCheckEnabled == _spellCheckEnabled;
  }

  @override
  int get hashCode => Object.hash(spellCheckService, misspelledTextStyle, spellCheckSuggestionsToolbarBuilder, _spellCheckEnabled);
}