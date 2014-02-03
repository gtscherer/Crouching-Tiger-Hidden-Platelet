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
#include <list>
#include "LineGeneratorEntity.h"

#define Force 0
#define Exclude 1
#define Integer_Pair std::pair<int, int>
#define Double_Pair std::pair<double, double>
#define ScaleFactors std::list< Double_Pair >

namespace ProceduralGenerator 
{
    class LineGeneratorEntity;
    
	class Rule
	{
	public:
        ProceduralGenerator::LineGeneratorEntity& getEntity();
		void setEntity(ProceduralGenerator::LineGeneratorEntity& entity);
        Integer_Pair getAreaAffected();
		void setAreaAffected(int, int);
		void setAreaAffected(Integer_Pair dimensions);
		Integer_Pair getOffset();
		void setOffset(int, int);
		void setOffset(Integer_Pair offset);
		int getRuleType();
	private:
		ProceduralGenerator::LineGeneratorEntity* entity;
		Integer_Pair areaAffected;
		Integer_Pair offset;
		int ruleType;
	};
}

#endif