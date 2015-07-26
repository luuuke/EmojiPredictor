#line 1 "/Users/ng/Dropbox/EmojiPredictionTweak/EmojiPredictionTweak/EmojiPredictionTweak.xm"
#import <objc/runtime.h>

#define kNumberOfCandidates [objc_getClass("UIKeyboardPredictionView") numberOfCandidates]

@class TIAutocorrectionList;

@interface TIKeyboardCandidateSingle : NSObject
+(id)candidateWithCandidate:(id)arg1 forInput:(id)arg2 ;
@end

@interface TIZephyrCandidate : TIKeyboardCandidateSingle
@end

@interface UIKeyboardEmojiCategory : NSObject
+(NSArray*)emojiRecentsFromPreferences;
@end

@interface UIKeyboardEmoji : NSObject
-(NSString*)emojiString;
@end

@interface UIKeyboardPredictionView : NSObject
+(NSInteger)numberOfCandidates;
-(void)_setPredictions:(NSArray*)predictions autocorrection:(TIAutocorrectionList*)autocorrection;
@end

#include <logos/logos.h>
#include <substrate.h>
@class UIKeyboardEmojiCategory; @class UIKeyboardPredictionView; @class TIZephyrCandidate; 
static void (*_logos_orig$_ungrouped$UIKeyboardPredictionView$_setPredictions$autocorrection$)(UIKeyboardPredictionView*, SEL, NSArray*, TIAutocorrectionList*); static void _logos_method$_ungrouped$UIKeyboardPredictionView$_setPredictions$autocorrection$(UIKeyboardPredictionView*, SEL, NSArray*, TIAutocorrectionList*); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$UIKeyboardEmojiCategory(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("UIKeyboardEmojiCategory"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$TIZephyrCandidate(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("TIZephyrCandidate"); } return _klass; }
#line 27 "/Users/ng/Dropbox/EmojiPredictionTweak/EmojiPredictionTweak/EmojiPredictionTweak.xm"



static void _logos_method$_ungrouped$UIKeyboardPredictionView$_setPredictions$autocorrection$(UIKeyboardPredictionView* self, SEL _cmd, NSArray* predictions, TIAutocorrectionList* autocorrection){
	LWLog(@"autocorrection: %@", autocorrection);
	LWLog(@"old predictions: %@", predictions);
	NSMutableArray* replacementPredictions=[NSMutableArray new];
	NSArray* recentEmojis=[_logos_static_class_lookup$UIKeyboardEmojiCategory() emojiRecentsFromPreferences];
	
	for(int i=0; i<kNumberOfCandidates && i<[recentEmojis count]; i++){
		if(kNumberOfCandidates/2 == i && autocorrection && [predictions count]>0){
			[replacementPredictions addObject:predictions[0]];
			
		}
		
		UIKeyboardEmoji* keyboardEmoji=recentEmojis[i];
		TIZephyrCandidate* emojiCandidate=[_logos_static_class_lookup$TIZephyrCandidate() candidateWithCandidate:keyboardEmoji.emojiString forInput:@""];
		[replacementPredictions addObject:emojiCandidate];
	}
	
	LWLog(@"new predictions: %@", replacementPredictions);
	[replacementPredictions autorelease];
	_logos_orig$_ungrouped$UIKeyboardPredictionView$_setPredictions$autocorrection$(self, _cmd, replacementPredictions, NULL);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIKeyboardPredictionView = objc_getClass("UIKeyboardPredictionView"); MSHookMessageEx(_logos_class$_ungrouped$UIKeyboardPredictionView, @selector(_setPredictions:autocorrection:), (IMP)&_logos_method$_ungrouped$UIKeyboardPredictionView$_setPredictions$autocorrection$, (IMP*)&_logos_orig$_ungrouped$UIKeyboardPredictionView$_setPredictions$autocorrection$);} }
#line 53 "/Users/ng/Dropbox/EmojiPredictionTweak/EmojiPredictionTweak/EmojiPredictionTweak.xm"
