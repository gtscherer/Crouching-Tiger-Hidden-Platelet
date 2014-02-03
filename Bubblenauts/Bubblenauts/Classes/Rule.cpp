#include "Rule.h"
#include "Entity.h"

using namespace ProceduralGenerator;

Rule::Rule()
{

}

Rule::~Rule()
{

}

Entity& Rule::getEntity()
{
	return this->entity;
}

void Rule::setEntity(Entity& entity)
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

void Rule::setAreaAffected(Integer_pair dimensions)
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