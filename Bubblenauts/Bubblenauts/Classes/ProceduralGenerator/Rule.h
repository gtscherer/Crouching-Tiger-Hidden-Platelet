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
#define Force 0
#define Exclude 1

namespace ProceduralGenerator 
{
    
	class Rule
	{
	public:
        char getEntity();
		void setEntity(char entity);
        std::pair<int, int> getAreaAffected();
		void setAreaAffected(int, int);
		void setAreaAffected(std::pair<int, int> dimensions);
		std::pair<int, int> getOffset();
		void setOffset(int, int); 
		void setOffset(std::pair<int, int> offset);
		int getRuleType();
	private:
		char entity;
		std::pair<int, int> areaAffected;
		std::pair<int, int> offset;
		int ruleType;
	};

}

#endif