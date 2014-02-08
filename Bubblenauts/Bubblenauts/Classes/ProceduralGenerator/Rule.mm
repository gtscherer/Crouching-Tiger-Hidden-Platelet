#include "Rule.h"


using namespace ProceduralGenerator;

Rule::Rule(char entity) : entity(entity) {}

Rule::Rule(char entity, int ruleType) : Rule::Rule(entity)
{
    this->ruleType = ruleType;
}

Rule::Rule(char entity, int ruleType, Integer_Pair areaAffected, Integer_Pair offset) : Rule::Rule(entity, ruleType)
{
    this->areaAffected = areaAffected;
    this->offset = offset;
}


char Rule::getEntity()
{
	return this->entity;
}

void Rule::setEntity(char entity)
{
	this->entity = entity;
}

Integer_Pair Rule::getAreaAffected()
{
	return this->areaAffected;
}

void Rule::setAreaAffected(int x, int y)
{
	this->areaAffected = Integer_Pair(x, y);
}

void Rule::setAreaAffected(Integer_Pair dimensions)
{
	this->areaAffected = dimensions;
}

Integer_Pair Rule::getOffset()
{
	return this->offset;
}

void Rule::setOffset(int x, int y)
{
	this->offset = Integer_Pair(x, y);
}

void Rule::setOffset(Integer_Pair offset)
{
	this->offset = offset;
}

int Rule::getRuleType()
{
	return this->ruleType;
}
