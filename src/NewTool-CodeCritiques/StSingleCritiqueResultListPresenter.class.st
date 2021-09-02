"
I display everything about critiques:
	- critiques violating the selected rule
	- options to do with the critiques
	- source code for the selected critique

I interact with StCritiqueToolbarPresenter to make actions on critiques. 
I interact with StCritiqueBrowserPresenter to get selected rules and show critiques.

You can open me whit:
`StSingleCritiqueResultListPresenter open`.



"
Class {
	#name : #StSingleCritiqueResultListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rule',
		'criticsModel',
		'sourceCodeModel',
		'cache',
		'thread',
		'toolbarModel'
	],
	#classInstVars : [
		'icons'
	],
	#category : #'NewTool-CodeCritiques-Parts'
}

{ #category : #specs }
StSingleCritiqueResultListPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #criticsModel;
		  add: #toolbarModel height: 25;
		  add: #sourceCodeModel;
		  yourself
]

{ #category : #icons }
StSingleCritiqueResultListPresenter class >> exclamationIcon [ 

	^  icons
			at: #'exclamationIcon'
			ifAbsentPut:[ Form fromBinaryStream: self exclamationIconContents base64Decoded readStream ].

]

{ #category : #icons }
StSingleCritiqueResultListPresenter class >> exclamationIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0
RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAJPSURBVDjLpZPLS5RhFMYfv9QJ
lelTQZwRb2OKlKuINuHGLlBEBEOLxAu46oL0F0QQFdWizUCrWnjBaDHgThCMoiKkhUONTqmj
mDp2GZ0UnWbmfc/ztrC+GbM2dXbv4ZzfeQ7vefKMMfifyP89IbevNNCYdkN2kawkCZKfSPZT
OGTf6Y/m1uflKlC3LvsNTWArr9BT2LAf+W73dn5jHclIBFZyfYWU3or7T4K7AJmbl/yG7EtX
1BQXNTVCYgtgbAEAYHlqYHlrsTEVQWr63RZFuqsfDAcdQPrGRR/JF5nKGm9xUxMyr0YBAEXX
HgIANq/3ADQobD2J9fAkNiMTMSFb9z8ambMAQER3JC1XttkYGGZXoyZEGyTHRuBuPgBTUu7V
SnUAgAUAWutOV2MjZGkehgYUA6O5A0AlkAyRnotiX3MLlFKduYCqAtuGXpyH0XQmOj+TIURt
51OzURTYZdBKV2UBSsOIcRp/TVTT4ewK6idECAihtUKOArWcjq/B8tQ6UkUR31+OYXP4sTOd
isivrkMyHodWejlXwcC38Fvs8dY5xaIId89VlJy7ACpCNCFCuOp8+BJ6A631gANQSg1mVmOx
xGQYRW2nHMha4B5WA3chsv22T5/B13AIicWZmNZ6cMchTXUe81Okzz54pLi0uQWp+TmkZqMw
xsBV74Or3od4OISPr0e3SHa3PX0f3HXKofNH/UIG9pZ5PeUth+CyS2EMkEqs4fPEOBJLsysk
e48/+xD8oxcAYPzs4QaS7RR2kbLTTOTQieczfzfTv8QPldGvTGoF6/8AAAAASUVORK5CYII='
]

{ #category : #'class initialization' }
StSingleCritiqueResultListPresenter class >> initialize [
	
	icons := IdentityDictionary new
]

{ #category : #icons }
StSingleCritiqueResultListPresenter class >> open [

	<example>
	^ self new openWithSpec
]

{ #category : #specs }
StSingleCritiqueResultListPresenter class >> title [

	^ 'Critique Browser'
]

{ #category : #icons }
StSingleCritiqueResultListPresenter class >> wrenchOrangeIcon [

	^  icons
			at: #'wrenchOrangeIcon'
			ifAbsentPut:[ Form fromBinaryStream: self wrenchOrangeIconContents base64Decoded readStream ].

]

{ #category : #icons }
StSingleCritiqueResultListPresenter class >> wrenchOrangeIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0
RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAHaSURBVDjLlZO7a1NRHMfzfzhI
KQ5OHR1ddRRBLA6lg4iTd5PSas37YR56Y2JiHgg21uoFxSatCVFjbl5iNBBiMmUJgWwZhCB4
pR9/V4QKfSQdDufF5/v7nu85xwJYprV0Oq0kk8luIpEw4vG48f/eVDiVSikCTobDIePxmGg0
yokEBO4OBgNGoxH5fJ5wOHwygVgsZpjVW60WqqqWzbVgMIjf78fn8xlTBcTy736/T7VaJRQK
fQoEArqmafR6Pdxu9/ECkUjkglje63Q6NBoNisUihUKBcrlMpVLB6XR2D4df3VQnmRstsWzU
63WazSZmX6vV0HWdUqmEw+GY2Gw25SC8dV1l1wrZNX5s3qLdbpPL5fB6vXumZalq2O32rtVq
VQ6GuGnCd+HbFnx9AZrC+MkSHo/np8vlmj/M7f4ks6yysyawgB8fwPv70HgKG8v8cp/7fFRO
/+AllewqNJ/DhyBsi9A7J1QTkF4E69mXRws8u6ayvSJwRqoG4K2Md+ygxyF5FdbPaMfdlIXU
ZfiyAUWx/OY25O4JHBP4CtyZ16a9EwuRi1CXs+5K1ew6lB9DXERX517P8tEsPDzfNIP6C5Ye
QewSrJyeCd4P0bnwXYISy3MCn5oZNtsf3pH46e7XBJcAAAAASUVORK5CYII='
]

{ #category : #menu }
StSingleCritiqueResultListPresenter >> addCriticToFalsePositive [

	criticsModel selectedItems ifNotNil: [ :items | 
		items do: [ :item | 
			cache addFalsePositive: item forRule: rule ] ]
]

{ #category : #menu }
StSingleCritiqueResultListPresenter >> addCritiqueToDo [

	criticsModel selectedItems ifNotNil: [ :items | 
		items do: [ :item | cache addToDo: item forRule: rule ] ]
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> applyTransformation [

	criticsModel selectedItem ifNotNil: [ :critique | 
		(StRewriteCritiqueChangesBrowserPresenter changes: { critique change })
			  open ]
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> banRule [

	| crit |
						  crit := criticsModel selectedItem.
						  crit guidedBan
]

{ #category : #menu }
StSingleCritiqueResultListPresenter >> browseCritic [
	criticsModel selectedItem
		ifNotNil: [ :element |
			| entity |
			entity := element sourceAnchor entity.
			entity isBehavior 
				ifTrue: [ entity instanceSide browse ]
				ifFalse: [ entity browse ] ] 
]

{ #category : #accessing }
StSingleCritiqueResultListPresenter >> buildMenuCritique [

	^ SpMenuPresenter new
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Browse' translated;
						  action: [ self browseCritic ] ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'Mark as wrong' translated;
					  visibleIf: [ self isCritiqueFalsePositive not ];
					  action: [ self addCriticToFalsePositive ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Unmark as wrong' translated;
					  visibleIf: [ self isCritiqueFalsePositive ];
					  action: [ self removeCriticToFalsePositive ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Unmark as To Do' translated;
					  visibleIf: [ self isCritiqueToDo ];
					  action: [ self removeCriticToDo ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Mark as To Do' translated;
					  visibleIf: [ self isCritiqueToDo not ];
					  action: [ self addCritiqueToDo ] ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'View rationale behind the rule' translated;
					  action: [ self rationaleOfRule ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Automatically resolve the issue' translated;
					  visibleIf: [ criticsModel selectedItem providesChange ];
					  action: [ self applyTransformation ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Ban this rule' translated;
					  action: [ self banRule ] ] ];
		  yourself
]

{ #category : #accessing }
StSingleCritiqueResultListPresenter >> cache: aCache [

	cache := aCache
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> connectPresenters [

	self whenSelectedItemChangesOnListModel
]

{ #category : #accessing }
StSingleCritiqueResultListPresenter >> criticsModel [
	^ criticsModel
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> criticsOf: aRule [
	cache ifNil: [^ {}].
	criticsModel items: ((cache criticsOf: aRule)
				sorted: [ :a :b | 
					a printString < b printString ]).
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> defaultColor [
	^ Color red 
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> diffSeparator [

	^ '——————————————————
	
'
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> diffTextForChange: aRefactoryChange [

	| text builder |
	text := Text new.
	builder := PrettyTextDiffBuilder new.
	aRefactoryChange changes
		do: [ :chng | 
			builder from: chng oldVersionTextToDisplay to: chng textToDisplay.
			text append: builder buildDisplayPatch ]
		separatedBy: [ text append: self diffSeparator ].

	^ text
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> falsePositiveColor [
	^ Color darkGray
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> formatCritic: aCritic [
	
	^  String streamContents: [:s | aCritic sourceAnchor entity criticNameOn: s ]

]

{ #category : #private }
StSingleCritiqueResultListPresenter >> iconFor: anItem [

	^ (cache isFalsePositive: anItem forRule: rule) ifFalse: [ 
		  (cache isToDo: anItem forRule: rule)
			  ifTrue: [ self class wrenchOrangeIcon ]
			  ifFalse: [ 
				  | severity |
				  severity := rule severity.
				  severity == #information
					  ifTrue: [ self iconNamed: #smallInfo ]
					  ifFalse: [ 
						  severity == #warning
							  ifTrue: [ self iconNamed: #smallWarning ]
							  ifFalse: [ self iconNamed: #smallError ] ] ] ]
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> initialize [

	super initialize.
	self initializeShortcuts
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> initializeDisplayCritic: aCritic forRule: aRule [

	| criticRepresentation |
	criticRepresentation := (self formatCritic: aCritic) asMorph.
	^ (cache isFalsePositive: aCritic forRule: aRule)
		  ifTrue: [ criticRepresentation color: self falsePositiveColor ]
		  ifFalse: [ 
			  (cache isToDo: aCritic forRule: aRule)
				  ifTrue: [ criticRepresentation color: self toDoColor ]
				  ifFalse: [ criticRepresentation color: self class theme textColor ] ]
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> initializePresenters [

	criticsModel := self newList.
	sourceCodeModel := self newSourceCodeCritique.
	toolbarModel := StCritiqueToolbarPresenter new.
	criticsModel beMultipleSelection.
	criticsModel display: [ :selec | 
		self initializeDisplayCritic: selec forRule: rule ].
	criticsModel contextMenu: self buildMenuCritique.
	criticsModel displayIcon: [ :item | self iconFor: item ].
	self focusOrder
		add: criticsModel;
		add: toolbarModel;
		add: sourceCodeModel
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> initializeShortcuts [
	criticsModel bindKeyCombination: PharoShortcuts current browseShortcut toAction: [ self browseCritic ]
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> isCritiqueFalsePositive [ 
	^ criticsModel selectedItems anySatisfy: [ :critic | 
								  (cache isFalsePositive: critic forRule: rule)]
]

{ #category : #menu }
StSingleCritiqueResultListPresenter >> isCritiqueToDo [
^ criticsModel selectedItems anySatisfy: [ :critic | 
		 cache isToDo: critic forRule: rule ]
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> newSourceCodeCritique [
	
	^ SpCodePresenter new beNotEditable.
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> rationaleOfRule [

	| crit |
						  crit := criticsModel selectedItem.
						  crit popDescriptionUp.
						  ReSystemAnnouncer uniqueInstance
							  notifyCritique: crit
							  descriptionViewedFor: crit sourceAnchor entity 
]

{ #category : #menu }
StSingleCritiqueResultListPresenter >> removeCriticToDo [

	criticsModel selectedItems ifNotNil: [ :items | 
		items do: [ :item | cache removeToDo: item forRule: rule ] ]
]

{ #category : #menu }
StSingleCritiqueResultListPresenter >> removeCriticToFalsePositive [

	criticsModel selectedItems ifNotNil: [ :items | 
		items do: [ :item | 
			cache removeFalsePositive: item forRule: rule ] ]
]

{ #category : #api }
StSingleCritiqueResultListPresenter >> resetSelection [
	self criticsModel resetListSelection
]

{ #category : #accessing }
StSingleCritiqueResultListPresenter >> rule [
	^ rule
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> rule: aRule [

	rule := aRule.
	(rule isNil or: [ rule isComposite ]) ifTrue: [ ^ self ].
	self criticsOf: aRule.
	toolbarModel rule: aRule.
]

{ #category : #'smartSuggestions - support' }
StSingleCritiqueResultListPresenter >> selectedMessage [
	^ nil
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> selectionIntervalFor: aString [
	^ rule result selectionIntervalFor: aString
]

{ #category : #accessing }
StSingleCritiqueResultListPresenter >> setFocusOrder [

	self focusOrder
		add: criticsModel;
		add: sourceCodeModel
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> setTextModelForClassOrMethod: aCritique [

	| entity |
	entity := aCritique sourceAnchor entity.
	self flag:
		'Another hack. We need a better way to display entities (because now we may get not only classes and methods. Maybe something like GTInspector presentations could work)'.
	sourceCodeModel text: ((entity respondsTo: #definition)
			 ifTrue: [ entity definitionString ]
			 ifFalse: [ entity asString ]).
	sourceCodeModel behavior: (entity isCompiledMethod
			 ifTrue: [ entity methodClass ]
			 ifFalse: [ nil ]).
	aCritique sourceAnchor providesInterval ifTrue: [ 
		sourceCodeModel selectionInterval: aCritique sourceAnchor interval ]
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> setTextModelForNil [

	| text |
	text := rule rationale isEmpty
		        ifTrue: [ rule name ]
		        ifFalse: [ rule rationale ].
	sourceCodeModel text: text.
	sourceCodeModel behavior: nil.
	toolbarModel critique: nil
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> setTextModelForTransformationRule: selection [
	
	sourceCodeModel behavior: nil.
	sourceCodeModel text: (
		self diffTextForChange: selection change).

									
					
]

{ #category : #accessing }
StSingleCritiqueResultListPresenter >> sourceCodeModel [ 

	^ sourceCodeModel
]

{ #category : #private }
StSingleCritiqueResultListPresenter >> toDoColor [
	^ Color orange
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> toolbarModel [

	^ toolbarModel
]

{ #category : #thread }
StSingleCritiqueResultListPresenter >> updateList [

	self criticsOf: rule.
	thread ifNotNil: [ thread terminate ].
	thread := [ UIManager default defer:  [ criticsModel updateList ]] fork.
]

{ #category : #initialization }
StSingleCritiqueResultListPresenter >> whenSelectedItemChangesOnListModel [

	criticsModel whenSelectionChangedDo: [ :aSelection | 
		| critique |
		critique := aSelection selectedItem.
		sourceCodeModel selectionInterval: (0 to: 0).
		rule ifNotNil: [ 
			critique ifNil: [ self setTextModelForNil ] ifNotNil: [ 
				toolbarModel critique: critique. 
				critique providesChange
					ifTrue: [ self setTextModelForTransformationRule: critique ]
					ifFalse: [ self setTextModelForClassOrMethod: critique ] ] ] ]
]