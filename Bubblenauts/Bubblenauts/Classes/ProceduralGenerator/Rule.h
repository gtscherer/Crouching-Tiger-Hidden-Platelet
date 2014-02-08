/*
Rule:
	entity: Entity
	dimensions: (int, int)
	offset: ((amount, direction), (amount, direction))
	Entity getEntity()
	type: force|exclude
*/
#ifndef RULE_H
#define RULE_H

#include <map>


#define Force 0
#define Exclude 1


namespace ProceduralGenerator 
{
    typedef std::pair<int, int> Integer_Pair;

	class Rule
	{
	public:
        Rule(char entity);
        Rule(char entity, int ruleType);
        Rule(char entity, int ruleType, Integer_Pair areaAffected, Integer_Pair offset);
        char getEntity();
		void setEntity(char entity);
        Integer_Pair getAreaAffected();
		void setAreaAffected(int, int);
		void setAreaAffected(Integer_Pair dimensions);
		Integer_Pair getOffset();
		void setOffset(int, int); 
		void setOffset(Integer_Pair offset);
		int getRuleType();
        void setRuleType(int ruleType);
	private:
		char entity;
		Integer_Pair areaAffected;
		Integer_Pair offset;
		int ruleType;
	};

}

#endif