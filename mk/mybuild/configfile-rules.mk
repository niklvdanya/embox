# Generated by GOLD Parser Builder using Mybuild program template.

# Rule productions for 'ConfigFile' grammar.

#
# As for symbols each rule can have a constructor that is used to produce an
# application-specific representation of the rule data.
# Production functions are named '$(gold_grammar)_produce-<ID>' and have the
# following signature:
#
# Params:
#   1..N: Each argument contains a value of the corresponding symbol in the RHS
#         of the rule production.
#
# Return:
#   The value to pass as an argument to a rule containing the production
#   of this rule in its RHS, or to return to user in case of the Start Symbol.
#
# If production function is not defined then the rule is produced by
# concatenating the RHS through spaces. To reuse this default value one can
# call 'gold_default_produce' function.
#

# Rule: <ConfigFile> ::= <Package> <Imports> <Type>
# Args: 1..3 - Symbols in the RHS.
define $(gold_grammar)_produce-ConfigFile
	$(for fileContent <- $(new CfgFileContentRoot),
		$(set fileContent->name,$1)
		$(set fileContent->imports,$2)
		$(set fileContent->configurations,$3)
		$(fileContent)
	)
endef

# Rule: <Package> ::= package <QualifiedName>
# Args: 1..2 - Symbols in the RHS.
$(gold_grammar)_produce-Package_package  = $2

# Rule: <Package> ::=
define $(gold_grammar)_produce-Package
	$(call gold_report_warning,
			Using default package)
endef

# Rule: <Import> ::= import <QualifiedNameWithWildcard>
$(gold_grammar)_produce-Import_import = $2

# Rule: <AnnotatedConfiguration> ::= <Annotations> <Configuration>
define $(gold_grammar)_produce-AnnotatedConfiguration
	$2
endef

# Rule: <Configuration> ::= configuration Identifier '{' <ConfigurationMembers> '}'
# Args: 1..5 - Symbols in the RHS.
define $(gold_grammar)_produce-Configuration_configuration_Identifier_LBrace_RBrace
	$(for cfg <- $(new CfgConfiguration),
		$(set cfg->name,$2)
		$(set cfg->origin,$(call gold_location_of,2))

		$(silent-foreach member,
				includes,
				$(set cfg->$(member),\
					$(filter-patsubst $(member)/%,%,$4)))

		$(cfg)
	)
endef

# Rule: <AnnotatedConfigurationMember> ::= <Annotations> <IncludeMember>
define $(gold_grammar)_produce-AnnotatedConfigurationMember
	$(for include <- $2,
		$(set include->annotations,$1)
		$(include))
endef

# Rule: <IncludeMember> ::= include <ReferenceWithInitializerList>
# Args: 1..2 - Symbols in the RHS.
define $(gold_grammar)_produce-IncludeMember_include
	$(addprefix $1s/,$2)
endef

# Rule: <ReferenceWithInitializerList> ::= <ReferenceWithInitializer> ',' <ReferenceWithInitializerList>
# Args: 1..3 - Symbols in the RHS.
$(gold_grammar)_produce-ReferenceWithInitializerList_Comma = $1 $3

# Rule: <ReferenceWithInitializer> ::= <Reference> <Initializer>
# Args: 1..2 - Symbols in the RHS.
define $(gold_grammar)_produce-ReferenceWithInitializer
	$(for link <- $1,
		include <- $(new CfgInclude),

		$(set include->module_link,$(link))
		$(set include->optionBindings,$2)

		$(include)
	)
endef

# Rule: <Initializer> ::= '(' <ParametersList> ')'
# Args: 1..3 - Symbols in the RHS.
$(gold_grammar)_produce-Initializer_LParan_RParan = $2

# Rule: <Annotations> ::= <Annotation> <Annotations>
# Args: 1..2 - Symbols in the RHS.
define $(gold_grammar)_produce-Annotations
	$(gold_default_produce)# TODO Auto-generated stub!
endef

# Rule: <Annotations> ::=
# Args: 1..0 - Symbols in the RHS.
define $(gold_grammar)_produce-Annotations2
	$(gold_default_produce)# TODO Auto-generated stub!
endef

# Rule: <Annotation> ::= '@' <Reference> <AnnotationInitializer>
# Args: 1..3 - Symbols in the RHS.
define $(gold_grammar)_produce-Annotation_At
	$(for annotation <- $(new MyAnnotation),
		$(set annotation->type_link,$2)
		$(set annotation->bindings,$3)
		$(annotation))
endef

# Rule: <AnnotationInitializer> ::= '(' <ParametersList> ')'
# Args: 1..3 - Symbols in the RHS.
define $(gold_grammar)_produce-AnnotationInitializer_LParan_RParan
	$(gold_default_produce)# TODO Auto-generated stub!
endef

# Rule: <AnnotationInitializer> ::= '(' <Value> ')'
# Args: 1..3 - Symbols in the RHS.
define $(gold_grammar)_produce-AnnotationInitializer_LParan_RParan2
	$(for binding<-$(new MyOptionBinding),
		$(set binding->option_link,$(new ELink,value,$(gold_location)))
		$(set binding->optionValue,$2)
		$(binding))
endef

# Rule: <ParametersList> ::= <Parameter> ',' <ParametersList>
# Args: 1..3 - Symbols in the RHS.
$(gold_grammar)_produce-ParametersList_Comma = $1 $3

# Rule: <ParametersList> ::= <Parameter>
# Args: 1..1 - Symbols in the RHS.
define $(gold_grammar)_produce-ParametersList
	$(gold_default_produce)# TODO Auto-generated stub!
endef

# Rule: <Parameter> ::= <SimpleReference> '=' <Value>
# Args: 1..3 - Symbols in the RHS.
define $(gold_grammar)_produce-Parameter_Eq
	$(for binding<-$(new MyOptionBinding),
		$(set binding->option_link,$1)
		$(set binding->optionValue,$3)
		$(binding))
endef

# Rule: <Value> ::= StringLiteral
$(gold_grammar)_produce-Value_StringLiteral = $(new MyStringOptionValue,$1)
# Rule: <Value> ::= NumberLiteral
$(gold_grammar)_produce-Value_NumberLiteral = $(new MyNumberOptionValue,$1)

# Rule: <Value> ::= BooleanLiteral
define $(gold_grammar)_produce-Value_BooleanLiteral
	$(gold_default_produce)# TODO Auto-generated stub!
endef

# Rule: <Value> ::= <Reference>
define $(gold_grammar)_produce-Value
	$(gold_default_produce)# TODO Auto-generated stub!
endef

# Rule: <Reference> ::= <QualifiedName>
$(gold_grammar)_produce-Reference                  = $(new ELink,$1,$(gold_location))
# Rule: <SimpleReference> ::= Identifier
$(gold_grammar)_produce-SimpleReference_Identifier = $(new ELink,$1,$(gold_location))

# <QualifiedName> ::= Identifier '.' <QualifiedName>
$(gold_grammar)_produce-QualifiedName_Identifier_Dot         = $1.$3
# <QualifiedNameWithWildcard> ::= <QualifiedName> '.*'
$(gold_grammar)_produce-QualifiedNameWithWildcard_DotTimes   = $1.*


$(def_all)

