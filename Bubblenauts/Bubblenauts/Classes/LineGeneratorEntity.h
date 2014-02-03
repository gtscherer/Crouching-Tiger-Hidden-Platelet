#include <list>
#include <queue>
#include <pair>
#include <map>
#include "Rule.h"
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


#define Rules std::list<Rule>
#define Integer_Pair std::pair<int, int>
#define Double_Pair std::pair<double, double>
#define ScaleFactors std::list< DoublePair >

using namespace std;

namespace ProceduralGenerator{
	class Entity{
	public:
        Entity(char symbol);
        Entity(char symbol, int frequency);
        Entity(char symbol, int frequency, Integer_Pair dimensions, ScaleFactors scaleFactors);
        Entity(char symbol, int frequency, Integer_pair dimensions,
               ScaleFactors scaleFactors, Rules exclusions, Rules ForceGenerate);
		Rules& getRules();
        void addExclusion(Rule);
        void addForceGeneration(Rule);
        void setFrequency(int);
		Integer_Pair getDimensions();
		void setDimensions(int x, int y);
		Double_Pair getScaleFactors();
		void setScaleFactors(double x, double y);
		char getSymbol();
		bool operator==(const Entity& lhs, const Entity& rhs);
		bool operator<(const Entity& lhs, const Entity& rhs);
		bool operator<=(const Entity& lhs, const Entity& rhs);
        
	private:
		Rules exclusions;
		Rules forceGeneration;
		Integer_Pair dimensions;
		Double_Pair scaleFactors;
		int frequency;
		char symbol;
	};
}