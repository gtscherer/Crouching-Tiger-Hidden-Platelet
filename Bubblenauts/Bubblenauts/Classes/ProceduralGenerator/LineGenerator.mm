#include "LineGenerator.h"
#include <time.h>

#define NotGenerated 'x'
#define Air '0'
#define Platform '1'
#define Bubble '2'
#define Suds '3'
#define Spike '4'
#define Fan '5'

using namespace ProceduralGenerator;
using namespace std;

deque<Rule> RuleList::getRules()
{
	return this->rules;
}

Rules RuleList::getExclusions()
{
	Rules exclusions;
	for(Rule rule : this->rules) if(rule.getRuleType() == Exclude) exclusions.push_back(rule);
	return exclusions;
}

Rules RuleList::getForceGenerate()
{
	Rules forceGenerate;
	for(Rule rule : this->rules) if(rule.getRuleType() == Force) forceGenerate.push_back(rule);
	return forceGenerate;
}


void RuleQueue::addRule(Rule rule, int row_number, int column_number)
{

}

Rule RuleQueue::peekRule(int column_number)
{
	return this->ruleQueue[column_number].getRules().front();
}

void RuleQueue::popRule(int column_number)
{
    this->ruleQueue[column_number].getRules().pop_front();
}

Distribution::Distribution()
{
    
}

Distribution::Distribution(map< Entity, int > distribution)
{
	this->distribution = distribution;
}

ProbabilityList Distribution::getProbabilityList()
{
	int position = 0;
	ProbabilityList probabilities; 
	for(auto& probabilityPair : this->distribution)
	{
		position += probabilityPair.second;
		probabilities.push_back(pair<int, Entity>(position, probabilityPair.first));
	}
	//normalize
	for(auto& probabilityPair : probabilities) probabilityPair.first = (probabilityPair.first / (position)) * 1000;
    return probabilities;
}

void Distribution::removeEntity(Entity entity)
{
	map< Entity, int > newDistribution;
	for(auto& probabilityPair : this->distribution)
	{
		if(&probabilityPair.first != &entity) newDistribution[probabilityPair.first] = probabilityPair.second;
	}
	this->distribution = newDistribution;
}

LineGenerator::LineGenerator()
{
    srand(time(0));
}

LineGenerator::LineGenerator(int width)
{
	this->width = width;
    srand(time(0));
}

void LineGenerator::setDistribution(Distribution distribution)
{
	this->globalDistribution = distribution;
}

Distribution LineGenerator::getDistribution()
{
	return this->globalDistribution;
}

char LineGenerator::generateEntity(ProbabilityList probabilities)
{
	int randomNumber = (rand() mod 1000);
	char entityToGenerate = Air;
	for(auto probabilityPair : distribution){
		if(randomNumber < probabilityPair.first) entityToGenerate = probabilityPair.second;
		else break;
	}
	return entityToGenerate;
}

char* LineGenerator::getNextLine()
{
	/*
	rules = ruleQueue.getRule(col_num)
	if(rules.getForceGenerate() == null)
    	evaluatedDist = evaluateDistribution(rules.getExclusions(), col_num)
    	entity = generateEntity(evaluatedDistribution)
	else
    	entity = rules.getForceGenerate()
	bool canPlace = true
	for(rule : entity.getRules())
		if(!ruleQueue.canPlace(rule.getEntity()))
    		canPlace = false
	if(canPlace)
        for(rule in entity.getRules())
        	ruleQueue.addRule(rule.getEntity())
    	generatedLine.addEntity(entity)
	else
    	generatedLine.addEntity(Air)
	++col_num
	*/
	string generatedLine;
	for(int column_number = 0; column_number < ruleQueue.size(); ++column_number)
	{
		Rules rules = this->ruleQueue.popRule(column_number);
		char entity;
		Rules forceGenerate = rules.getForceGenerate();
		if(forceGenerate.size() < 1){
			Distribution evaluatedDistribution = evaluateDistribution(rules.getExclusions(), column_number);
			entity = generateEntity(evaluatedDistribution);
		}
		else if(forceGenerate.size() == 1) entity = forceGenerate.front.getSymbol();
		bool canPlace = true;
		for(Rule rule : entity.getRules())
		{
			if(!ruleQueue.canPlace(rule.getEntity())){
				canPlace = false;
				break;
			}
		}
		if(canPlace){
			for(Rule rule : entity.getRules()) ruleQueue.addRule(rule);
			generatedLine += entity;
		}
		else generatedLine += Air;
	}
}

