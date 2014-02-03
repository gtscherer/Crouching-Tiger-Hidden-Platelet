/*
Rule:
	entity: Entity
	dimensions: (int, int)
	offset: ((amount, direction), (amount, direction))
	Entity getEntity()
	type: force|exclude
*/
#include <pair>
#include <list>
#include "Entity.h"
#define Integer_Pair std::pair<int, int>
#define Force 0
#define Exclude 1
namespace ProceduralGenerator 
{
	class Rule
	{
	public:
		Entity& getEntity();
		void setEntity(Entity& entity);
		Integer_Pair getAreaAffected();
		void setAreaAffected(int, int);
		void setAreaAffected(Integer_Pair dimensions);
		Integer_Pair getOffset();
		void setOffset(int, int);
		void setOffset(Integer_Pair offset);
		int getRuleType();
	private:
		Entity* entity;
		Integer_Pair areaAffected;
		Offset offset;
		int ruleType;
	};
}