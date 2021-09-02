"
I am a presenter that allows to select items from a list of rules organized by group in my left column and put that items on a selected list in my rigth column. I support selection for SpTreeTablePresenter. 

If you click on '>', I can add a group rules or a singe rule to selected list.
If you click on '<', I can remove a group rules or a singe rule from selected list.

If you click on 'Next', I will open the StCritiqueBrowserPresenter.
I send selected rules from selected list to StCritiqueBrowserPresenter. 

You can open me whit:
`StCritiqueRuleSelectorPresenter open`

"
Class {
	#name : #StCritiqueRuleSelectorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'selectedList',
		'selectedItems',
		'list',
		'addAllButton',
		'methodName',
		'addButton',
		'removeAllButton',
		'buttonBar',
		'removeButton',
		'items',
		'nextButton',
		'selectedRules',
		'environment',
		'removeTestCase'
	],
	#category : #'NewTool-CodeCritiques-Applier'
}

{ #category : #'instance creation' }
StCritiqueRuleSelectorPresenter class >> items [

	| rules rulesByGroup |
	rules := (ReRuleManager visibleRuleClasses collect: [ :aClass | 
		          aClass new ]) sorted: [ :a :b | a name < b name ].
	rulesByGroup := (rules groupedBy: #group) associations collect: [ :as | 
		                CBCritiquesRuleGroup
			                named: as key
			                rules: as value ].
	rulesByGroup sort: [ :a :b | a name < b name ].
	^ rulesByGroup
]

{ #category : #'instance creation' }
StCritiqueRuleSelectorPresenter class >> open [

	<example>
	| packages env |
	packages := RPackageOrganizer default packages.
	env := RBPackageEnvironment new packages: packages.
	^ (self openWithEnvironment: env removeTestCase: false)
]

{ #category : #'instance creation' }
StCritiqueRuleSelectorPresenter class >> openWithEnvironment: anEnvironment removeTestCase: aBoolean [

	^ self new
		items: self items;
		environment: anEnvironment;
		removeTestCase: aBoolean;
		updateTree;
		openWithSpec
		
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> addAll [

	selectedList roots do: [ :group | selectedRules addAll: group rules ].
	self update.
	nextButton enabled: selectedRules isNotEmpty.
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> addAllButton [

	^ addAllButton
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> addButton [

	^ addButton
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> addSelected [

	list selectedItem ifNotNil: [ :item | 
		item isComposite
			ifFalse: [ selectedRules add: item ]
			ifTrue: [ selectedRules addAll: item rules ] ].
	self update.
	nextButton enabled: selectedRules isNotEmpty.
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> defaultTitle [

	^ 'Select rules'
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> environment: aEnviroment [

	environment := aEnviroment
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> groupRules [
	^ #(
	#'API Change'
	#'API Hints'
	#'Architectural'
	#'Bugs'
	#'Coding Idiom Violation'
	#'Design Flaws'
	#'Optimization'
	#'Potential Bugs'
	#'Rubric'
	#'SUnit'
	#'Style'
	#'Unclassified rules'  )
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initalizeSelectedList [

	selectedList := self instantiate: SpTreePresenter
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initialize [

	| wrappingBlock selectedRulesChildrenBlock rulesToSelectChildrenBlock |
	super initialize.
	self initializeList.
	self initalizeSelectedList.
	selectedRules := Set new.
	selectedRulesChildrenBlock := [ :rule | 
	                              rule isComposite
		                              ifTrue: [ 
			                              rule rules select: [ :r | 
				                              (self isSelected: r) or: [ 
					                              r isComposite ] ] ]
		                              ifFalse: [ #(  ) ] ].
	rulesToSelectChildrenBlock := [ :rule | 
	                              rule isComposite
		                              ifTrue: [ 
			                              rule rules select: [ :r | 
				                              (self isSelected: r) not or: [ 
					                              r isComposite ] ] ]
		                              ifFalse: [ #(  ) ] ].
	list children: rulesToSelectChildrenBlock.
	selectedList children: selectedRulesChildrenBlock.
	wrappingBlock := [ :rule | rule name ].
	list display: wrappingBlock.
	selectedList display: wrappingBlock
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initializeButtonBar [

	buttonBar 
		add: self addButton 
			expand: false;
		add: self addAllButton
			expand: false;
		add: self removeButton
			expand: false;
		add: self removeAllButton
			expand: false
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initializeButtons [

	addButton := self newButton
				addStyle: 'small';
				label: '>';
				action: [ self addSelected ];
				yourself.

	addAllButton := self newButton
				addStyle: 'small';
				label: '>>';
				action: [ self addAll ];
				yourself.

	removeButton := self newButton
				addStyle: 'small';
				label: '<';
				action: [ self removeSelected ];
				yourself.

	removeAllButton := self newButton
				addStyle: 'small';
				label: '<<';
				action: [ self removeAll ];
				yourself
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initializeLayout [

	self layout: (SpBoxLayout newTopToBottom
			 add: (SpBoxLayout newTopToBottom
					  spacing: 5;
					  add: (SpPanedLayout newLeftToRight
							   add: (SpBoxLayout newLeftToRight
									    spacing: 5;
									    add: #list;
									    add: (buttonBar := SpBoxLayout newTopToBottom)
									    expand: false;
									    yourself);
							   add: #selectedList;
							   yourself);
					  yourself);
			 add: (SpBoxLayout newLeftToRight
					  addLast: #nextButton;
					  yourself)
			 height: 25;
			 yourself)
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initializeList [

	list := self instantiate: SpTreePresenter.
	removeButton := self newButton
				addStyle: 'small';
				label: '<';
				action: [ self removeSelected ];
				yourself.

	removeAllButton := self newButton
				addStyle: 'small';
				label: '<<';
				action: [ self removeAll ];
				yourself
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initializeNextButton [

	nextButton := self newButton.
	nextButton
		icon: (self iconNamed: #smallOk);
		label: 'Next';
		enabled: false;
		action: [ self nextAction ]
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> initializePresenters [

	self initializeLayout.
	self initializeList.
	self initalizeSelectedList.
	self initializeButtons.
	self initializeButtonBar.
	self initializeNextButton
]

{ #category : #initialization }
StCritiqueRuleSelectorPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self defaultTitle;
		initialExtent: 450 @ 360
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> isSelected: aRule [

	"Check the rule identifier to not run twice the same rule"

	^ selectedRules anySatisfy: [ :rule | 
		  rule class uniqueIdentifierName = aRule class uniqueIdentifierName ]
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> items: aCollection [

	list roots: aCollection.
	selectedList roots: aCollection
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> list [
	
	^ list
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> list: anObject [

	list := anObject
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> methodName [

	^ methodName
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> nextAction [

	self delete.

	CBCritiqueWorkingConfiguration current
		rule: selectedRules;
		environment: environment;
		removeTestCase: removeTestCase.
	StCritiqueBrowserPresenter openOnWorkingConfiguration:
		CBCritiqueWorkingConfiguration current
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> removeAll [

	selectedList roots do: [ :item | 
		selectedRules removeAllFoundIn: item value ].
	self update.
	nextButton enabled: selectedRules isNotEmpty
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> removeAllButton [

	^ removeAllButton
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> removeButton [

	^ removeButton
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> removeSelected [

	selectedList selectedItem ifNotNil: [ :item | 
		(self groupRules includes: item name)
			ifTrue: [ selectedRules removeAll: item rules ]
			ifFalse: [ selectedRules remove: item ] ].
	self update.
	nextButton enabled: selectedRules isNotEmpty
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> removeTestCase: aBoolean [

	removeTestCase := aBoolean
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> selectedItems [

	^ selectedItems ifNil: [ selectedItems := #() ]
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> selectedList [

	^ selectedList
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> selectedList: anObject [

	selectedList := anObject
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> selectedRules [

	^ selectedRules
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> selectedRules: anObject [

	selectedRules := anObject
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> setModelBeforeInitialization: aCollection [

	items := aCollection first.
	selectedItems := aCollection second.
	methodName := aCollection third
]

{ #category : #adding }
StCritiqueRuleSelectorPresenter >> updateTree [

	list update.
	selectedList update
]