#include "Rule.h"

using namespace ProceduralGenerator;


LineGeneratorEntity& Rule::getEntity()
{
	return *this->entity;
}

void Rule::setEntity(LineGeneratorEntity& entity)
{
	this->entity = &entity;
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
