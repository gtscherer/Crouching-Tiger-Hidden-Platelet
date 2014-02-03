#ifndef LINEGENERATORENTITY_H
#define LINEGENERATORENTITY_H

#include <queue>
#include <map>
#include <list>

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

#define Rules std::list< ProceduralGenerator::Rule >
#define Integer_Pair std::pair<int, int>
#define Double_Pair std::pair<double, double>
#define ScaleFactors std::list< Double_Pair >
#define RulePointerList std::list<Rule*>


namespace ProceduralGenerator{
    class Rule;
    
	class LineGeneratorEntity{
	public:
        LineGeneratorEntity(char symbol);
        LineGeneratorEntity(char symbol, int frequency);
        LineGeneratorEntity(char symbol, int frequency, Integer_Pair dimensions, ScaleFactors scaleFactors);
        LineGeneratorEntity(char symbol, int frequency, Integer_Pair dimensions, ScaleFactors scaleFactors, Rules exclusions, Rules forceGenerate);
		RulePointerList getRules();
        void addExclusion(ProceduralGenerator::Rule);
        void addForceGeneration(ProceduralGenerator::Rule);
        void setFrequency(int);
		Integer_Pair getDimensions();
		void setDimensions(int x, int y);
		ScaleFactors getScaleFactors();
		void setScaleFactors(ScaleFactors scaleFactors);
        void addScaleFactors(double x, double y);
		char getSymbol();
        bool operator==(const LineGeneratorEntity& rhs);
        bool operator<(const LineGeneratorEntity& rhs);
        bool operator<=(const LineGeneratorEntity& rhs);
        bool operator!=(const LineGeneratorEntity& rhs);
	private:
		Rules exclusions;
		Rules forceGeneration;
		Integer_Pair dimensions;
		ScaleFactors scaleFactors;
		int frequency;
        char symbol;
	};
}

#endif