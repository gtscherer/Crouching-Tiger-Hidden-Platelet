/*
LineGeneratorEntity:
        	symbol: char
        	exclusions: list<Rule>
        	forceGeneration: list<Rule>
        	dimensions: (int, int)
        	scale_factors: (float, float)
        	frequency: int
        	Rules getRules()
*/
#include "LineGeneratorEntity.h"

using namespace std;
using namespace ProceduralGenerator;


LineGeneratorEntity::LineGeneratorEntity(char symbol) : symbol(symbol) {}

LineGeneratorEntity::LineGeneratorEntity(char symbol, int frequency) :
    LineGeneratorEntity::LineGeneratorEntity(symbol)
{
    this->frequency = frequency;
}

LineGeneratorEntity::LineGeneratorEntity(char symbol, int frequency, Integer_Pair dimensions, ScaleFactors scaleFactors) :
    LineGeneratorEntity::LineGeneratorEntity(symbol, frequency)
{
    this->dimensions = dimensions;
    this->scaleFactors = scaleFactors;
}

LineGeneratorEntity::LineGeneratorEntity(char symbol,
               int frequency,
               Integer_Pair dimensions,
               ScaleFactors scaleFactors,
               Rules exclusions,
               Rules forceGenerate) :
               LineGeneratorEntity::LineGeneratorEntity(symbol, frequency, dimensions, scaleFactors)

{
    this->exclusions = exclusions;
    this->forceGeneration = forceGenerate;
}



char LineGeneratorEntity::getSymbol()
{
	return this->symbol;
}

bool LineGeneratorEntity::operator==(const LineGeneratorEntity& rhs)
{
	if(this->getSymbol() == rhs.symbol) return true;
	else return false;
}

bool LineGeneratorEntity::operator<(const LineGeneratorEntity& rhs)
{
	if(this->getSymbol() < rhs.symbol) return true;
	else return false;
}

bool LineGeneratorEntity::operator<=(const LineGeneratorEntity& rhs)
{
	if(this->getSymbol() <= rhs.symbol) return true;
	else return false;
}

bool LineGeneratorEntity::operator!=(const LineGeneratorEntity& rhs)
{
    if(this == &rhs) return false;
    else return true;
}

Rules LineGeneratorEntity::getForceGeneration()
{
    return this->forceGeneration;
}

Rules LineGeneratorEntity::getExclusions()
{
    return this->exclusions;
}

//must delete result in callback!!
RulePointerList LineGeneratorEntity::getRules()
{
	RulePointerList aggregate;
	for(Rule& rule : this->forceGeneration) aggregate.push_back(&rule);
	for(Rule& rule : this->exclusions) aggregate.push_back(&rule);
	return aggregate;
}


Integer_Pair LineGeneratorEntity::getDimensions()
{
	return this->dimensions;
}

void LineGeneratorEntity::setDimensions(int x, int y)
{
	this->dimensions = Integer_Pair(x, y);
}

ScaleFactors LineGeneratorEntity::getScaleFactors()
{
	return this->scaleFactors;
}

void LineGeneratorEntity::setScaleFactors(ScaleFactors scaleFactors)
{
	this->scaleFactors = scaleFactors;
}

void LineGeneratorEntity::addScaleFactors(double x, double y)
{
    this->scaleFactors.push_back( Double_Pair(x, y) );
}