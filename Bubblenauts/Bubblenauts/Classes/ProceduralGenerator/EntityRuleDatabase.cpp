//
//  EntityRuleDatabase.cpp
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/6/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#include "EntityRuleDatabase.h"
/*
using namespace ProceduralGenerator;

EntityRuleMapping::EntityRuleMapping(Entity entity, ProceduralGenerator::Rule rule)
{
    this->entity = entity;
    this->rules.push_back(rule);
}

EntityRuleMapping::EntityRuleMapping(Entity entity, Rules rules)
{
    this->entity = entity;
    this->rules = rules;
}

Entity EntityRuleMapping::getEntity()
{
    return this->entity;
}

void EntityRuleMapping::setEntity(Entity entity)
{
    this->entity = entity;
}

Rules EntityRuleMapping::getRules()
{
    return this->rules;
}

void EntityRuleMapping::setRules(Rules rules)
{
    this->rules = rules;
}

void EntityRuleMapping::addRule(Rule rule)
{
    this->rules.push_back(rule);
}

Rules EntityRuleMapping::getForceGenerate()
{
    Rules forceGenerate;
    for(auto rule : this->rules)
    {
        if(rule.getRuleType() == Force) forceGenerate.push_back(rule);
    }
    return forceGenerate;
}

Rules EntityRuleMapping::getExclusions()
{
    Rules exclusions;
    for(auto rule : this->rules)
    {
        if(rule.getRuleType() == Exclude) exclusions.push_back(rule);
    }
    return exclusions;
}

bool RelationshipDatabase::addRule(char entity, ProceduralGenerator::Rule rule)
{
    for(EntityRuleMapping& mapping : this->database)
    {
        if(mapping.getEntity() == entity)
        {
            mapping.addRule(rule);
            return true;
        }
    }
    return false;
}

bool RelationshipDatabase::addRelationship(Entity entity, ProceduralGenerator::Rule rule)
{
    for(EntityRuleMapping& mapping : this->database)
    {
        if(mapping.getEntity() == entity) return false;
    }
    EntityRuleMapping newMapping(entity, rule);
    this->database.push_back(newMapping);
    return true;
}
*/