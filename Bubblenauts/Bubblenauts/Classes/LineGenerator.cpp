#include "LineGenerator.h"
#include "LineGeneratorEntity.h"
#include "Rule.h"
#include <time.h>

#define NotGenerated 'x'
#define Air '0'
#define Platform '1'
#define Bubble '2'
#define Suds '3'
#define Spike '4'
#define Fan '5'

using namespace ProceduralGenerator;

RuleList::RuleList()
{

}

RuleList::~RuleList()
{

}

Rules RuleList::getRules()
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

RuleQueue::RuleQueue() {}

RuleQueue::RuleQueue(int size)
{
	this->ruleQueue = queue<RuleList>[size];
}

RuleQueue::~RuleQueue()
{

}

void addRule(Rule rule, int row_number, int column_number){

}

Rule RuleQueue::peekRule(int column_number)
{
	return this->ruleQueue[column_number].front();
}

Rule RuleQueue::popRule(int column_number)
{
	return this->ruleQueue[column_number].pop();
}

Distribution::Distribution(std::map< Entity, int > distribution)
{
	this->distribution = distribution;
}

Distribution::~Distribution()
{

}

ProbabilityList Distribution::getProbabilityList()
{
	int position = 0;
	ProbabilityList probabilities; 
	for(auto& probabilityPair : this->distribution)
	{
		position += *probabilityPair.second;
		probabilities.push_back(std::pair<int, Entity>(position, *probabilityPair.first));
	}
	//normalize
	for(auto& probabilityPair : probabilities) *probabilityPair.first = (*probabilityPair.first / (position)) * 1000;
}	return probabilities;

void Distribution::removeEntity(char Entity)
{
	std::map< Entity, int > newDistribution;
	for(auto& probabilityPair : this->distribution)
	{
		if(probabilityPair.first.getSymbol() != Entity) newDistribution[probabilityPair.first] = probabilityPair.second;
	}
	this->distribution = newDistribution;
}

LineGenerator::LineGenerator()
{
    std::srand(time(0));
}

LineGenerator::LineGenerator(int width)
{
	this->width = width;
    std::srand(time(0));
}

LineGenerator::~LineGenerator()
{

}

void LineGenerator::setDistribution(Distribution distribution)
{
	this->distribution = distribution;
}

Distribution LineGenerator::getDistribution()
{
	return this->distribution;
}

char LineGenerator::generateEntity(ProbabilityList probabilities)
{
	int randomNumber = std::rand() mod 1000;
	entityToGenerate = Air;
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
	std::string generatedLine;
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

