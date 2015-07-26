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

%hook UIKeyboardPredictionView

//shoutout to PoomSmart @ https://github.com/PoomSmart/MorePredict/
-(void)_setPredictions:(NSArray *)predictions autocorrection:(TIAutocorrectionList *)autocorrection{
	LWLog(@"autocorrection: %@", autocorrection);
	LWLog(@"old predictions: %@", predictions);
	NSMutableArray* replacementPredictions=[NSMutableArray new];
	NSArray* recentEmojis=[%c(UIKeyboardEmojiCategory) emojiRecentsFromPreferences];
	for(int i=0; i<15 && i<[recentEmojis count]; i++){
		UIKeyboardEmoji* keyboardEmoji=recentEmojis[i];
		TIZephyrCandidate* emojiCandidate=[%c(TIZephyrCandidate) candidateWithCandidate:keyboardEmoji.emojiString forInput:@""];
		[replacementPredictions addObject:emojiCandidate];
	}
	LWLog(@"new predictions: %@", replacementPredictions);
	[replacementPredictions autorelease];
	%orig(replacementPredictions, NULL);
}

%end