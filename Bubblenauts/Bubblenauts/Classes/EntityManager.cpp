//
//  EntityManager.cpp
//  Bubblenauts
//
//  Created by Breton Goers on 11/12/13.
//
//

#include "EntityManager.h"
#include "Entity.h"
#include "Component.h"

#pragma mark -
#pragma mark Initialization Functions

EntityManager::EntityManager()
{
    // Start with an ID of 1 for all objects
    m_lowestEID = 1;
    
    // Use static initializer to create an empty (mutable) array. This is basically
    // just a vector. The create() method returns an autoreleased object, so we must
    // retain it to keep it around.
    m_pEntities = CCArray::create();
    m_pEntities->retain();
    
    // Just the same as above, we get an autoreleased dictionary to track our comps.
    // This must be retained to stick around.
    m_pComponentsByClass = CCDictionary::create();
    m_pComponentsByClass->retain();
}

EntityManager::~EntityManager()
{
    // Safely release the array and dictionary that we have retained earlier
    CC_SAFE_RELEASE_NULL(m_pEntities);
    CC_SAFE_RELEASE_NULL(m_pComponentsByClass);
}

EntityManager* EntityManager::entityManager(void)
{
    EntityManager *manager = new EntityManager();
    if (manager) {
        manager->autorelease();
        return manager;
    }
    CC_SAFE_DELETE(manager);
    return NULL;
}

#pragma mark -
#pragma mark Entity Creation

Entity* EntityManager::createEntity()
{
    // Create an entity with the eid from generateNewEID()
    uint32_t eID = this->generateNewEID();
    Entity *entity = Entity::entityWithID(eID);
    
    CCInteger *wrap = CCInteger::create(eID);
    m_pEntities->addObject(wrap);
    
    return entity;
}

uint32_t EntityManager::generateNewEID()
{
    // If we aren't maxed out, return and increment. Otherwise check our array
    // for any open spots. If none available, we've blown up.
    
    if ( m_lowestEID < UINT32_MAX ) {
        return m_lowestEID++;
    }
    else {
        for (uint32_t i = 0; i < UINT32_MAX; i++) {
            CCInteger *wrap = CCInteger::create(i);
            if ( !(m_pEntities->containsObject(wrap)) ) {
                return i;
            }
        }
        CCLog("Looks like we had a flagrant error");
        return 0;
    }
}

#pragma mark -
#pragma mark Adding and Accessing Components

void EntityManager::addComponentWithNameToEntity(Component* comp,
                                                 std::string compClass,
                                                 Entity* ent)
{
    // So the structure is like this - our class member m_pComponentsByClass
    //  contains objects, where the keys are the names of components classes.
    // The object returned by querying it with a key is another dictionary.
    //  This sub-dictionary contains actual component objects, with the entity
    //  ID as the key for each
    //
    // So here is a sample structure (where anything in '' is a key):
    //
    // m_pComponentsByClass : {
    //      'HealthComponent' : {
    //          '1' : Component,
    //          '2' : Component
    //      },
    //      'VelocityComponent' : {
    //          '1' : Component
    //      }
    // }
    CCDictionary *components = (CCDictionary*)m_pComponentsByClass->objectForKey(compClass);
    if (!components) {
        components = CCDictionary::create();
        m_pComponentsByClass->setObject(components, compClass);
    }
    
    int entID = ent->getEID();
    CCString *keyStr = CCString::createWithFormat("%d", entID);
    components->setObject(comp, keyStr->m_sString);
}










