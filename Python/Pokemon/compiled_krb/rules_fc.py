# rules_fc.py

from pyke import contexts, pattern, fc_rule, knowledge_base

pyke_version = '1.1.1'
compiler_version = 1

def may_live(rule, context = None, index = None):
  engine = rule.rule_base.engine
  if context is None: context = contexts.simple_context()
  try:
    with knowledge_base.Gen_once if index == 0 \
             else engine.lookup('pokemons', 'next_to', context,
                                rule.foreach_patterns(0)) \
      as gen_0:
      for dummy in gen_0:
        with knowledge_base.Gen_once if index == 1 \
                 else engine.lookup('pokemons', 'live_in', context,
                                    rule.foreach_patterns(1)) \
          as gen_1:
          for dummy in gen_1:
            engine.assert_('pokemons', 'may_live',
                           (rule.pattern(0).as_data(context),
                            rule.pattern(1).as_data(context),)),
            rule.rule_base.num_fc_rules_triggered += 1
  finally:
    context.done()

def populate(engine):
  This_rule_base = engine.get_create('rules')
  
  fc_rule.fc_rule('may_live', This_rule_base, may_live,
    (('pokemons', 'next_to',
      (contexts.variable('area1'),
       contexts.variable('area2'),),
      False),
     ('pokemons', 'live_in',
      (contexts.variable('pokemon'),
       contexts.variable('area1'),),
      False),),
    (contexts.variable('pokemon'),
     contexts.variable('area2'),))


Krb_filename = '../IE/rules.krb'
Krb_lineno_map = (
    ((12, 16), (3, 3)),
    ((17, 21), (4, 4)),
    ((22, 24), (6, 6)),
)
