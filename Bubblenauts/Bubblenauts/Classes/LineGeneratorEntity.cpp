/*
Entity:
        	symbol: char
        	exclusions: list<Rule>
        	forceGeneration: list<Rule>
        	dimensions: (int, int)
        	scale_factors: (float, float)
        	frequency: int
        	Rules getRules()
*/
#define RulePointerList std::list<Rule*>
#include "LineGeneratorEntity.h"

using namespace std;
using namespace ProceduralGenerator;


Entity::Entity()
{
    
}

Entity::Entity(char symbol)
{
    this->symbol = symbol;
}

Entity::Entity(char symbol, int frequency)
{
    this(symbol);
    this->frequency = frequency;
}

Entity::Entity(char symbol, int frequency)
{
    this(symbol);
    this->frequency = frequency;
}


Entity::~Entity()
{

}

char Entity::getSymbol()
{
	return this->symbol;
}

bool Entity::operator==(const Entity& lhs, const Entity& rhs)
{
	if(lhs.symbol == rhs.symbol) return true;
	else return false;
}

bool Entity::operator<(const Entity& lhs, const Entity& rhs)
{
	if(lhs.symbol < rhs.symbol) return true;
	else return false;
}

bool Entity::operator<=(const Entity& lhs, const Entity& rhs)
{
	if(lhs.symbol <= rhs.symbol) return true;
	else return false;
}

//must delete result in callback!!
Rules& Entity::getRules()
{
	RulePointerList* aggregate = new Rules();
	for(Rule rule : this->forceGeneration) *aggregate.push_back(&rule);
	for(Rule rule : this->exclusions) *aggregate.push_back(&rule);
	return aggregate;
}


Integer_Pair Entity::getDimensions()
{
	return this->dimensions;
}

void Entity::setDimensions(int x, int y)
{
	this->dimensions = Integer_Pair(x, y);
}

Double_Pair Entity::getScaleFactors()
{
	return this->scaleFactors;
}

void Entity::setScaleFactors(double x, double y)
{
	this->scaleFactors = Double_Pair(x, y);
}