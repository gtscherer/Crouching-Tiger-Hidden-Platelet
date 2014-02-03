#include "Entity.h"
#include "Rule.h"
#include <list>
#include <queue>
#include <map>
#include <pair>
#define Rules std::list<Rule>
#define ProbabilityList std::list< pair<int, Entity> >
namespace ProceduralGenerator
{
	class RuleList
	{
	public:
		Rules getExclusions();
		Rules getForceGenerate();
	private:
		Rules rules;
	};

	class RuleQueue
	{
	public:
		RuleQueue(int size);
		Rule peekRule(int column_number);
		Rule popRule(int column_number);
		Rule addRule(Rule rule, int column_number);
		void addRule(int row_number, int column_number);
	private:
		queue< RuleList > ruleQueue[];
	};

	class Distribution
	{
	public:
		Distribution(std::map< Entity, int > distribution);
		ProbabilityList getProbabilityList();
		void removeEntity(char entity);
	private:
		std::map< Entity,  int > distribution;

	};

	class LineGenerator
	{
	public:
		LineGenerator(int);
		char generateEntity();
		char* getNextLine();
		Distribution evaluateDistribution(Rules exclusions, int column_number);
		void setDistribution(Distribution);
		Distribution getDistribution;

	private:
		Distribution globalDistribution;
		RuleQueue ruleQueue;
		int width;

	};
}