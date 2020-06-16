#ifndef PREFIX
/********                      ********/
/******** namespaces, prefixes ********/
/********                      ********/
#define TAG UPSL
#define ADDON aime

#define PREFIX2(s0, s1) s0##_##s1
#define PREFIX3(s0, s1, s2) s0##_##s1##_##s2
#define NS2(s0, s1) s0##\##s1
#define NS3(s0, s1, s2) s0##\##s1##\##s2
#define SHARED_PREFIX PREFIX2(TAG,ADDON)
#define ADDON_NS \##NS2(TAG,ADDON)
#define SHARED_NS NS2(ADDON_NS,shared)

#ifdef COMPONENT
#define PREFIX PREFIX2(SHARED_PREFIX,COMPONENT)
#define NS NS2(ADDON_NS,COMPONENT)
#else
#define PREFIX SHARED_PREFIX
#define NS SHARED_NS
#endif

#define VAR(s) PREFIX2(PREFIX,s)
#define SVAR(s) PREFIX2(SHARED_PREFIX,s)
#define CLAS(s) VAR(s)
#define FNC(s) PREFIX3(PREFIX,fnc,s)
#define SFNC(s) PREFIX3(SHARED_PREFIX,fnc,s)
#define FILE(s) NS2(NS,s)
/********           ********/
/******** utilities ********/
/********           ********/
#define QUOT(s) #s
#define ARR2(s0, s1) [(s0), (s1)]
#define ARR3(s0, s1, s2) [(s0), (s1), (s2)]
#define ARR4(s0, s1, s2, s3) [(s0), (s1), (s2), (s3)]
#define ARR5(s0, s1, s2, s3, s4) [(s0), (s1), (s2), (s3), (s4)]
#define SMALLER(n0, n1) if ((n0) < (n1)) then { (n0) } else { (n1) }
#define GREATER(n0, n1) if ((n0) > (n1)) then { (n0) } else { (n1) }
/********              ********/
/******** CBA settings ********/
/********              ********/

#define SETTING(s) PREFIX3(PREFIX,setting,s)
#define SSETTING(s) PREFIX3(SHARED_PREFIX,setting,s)
/********                   ********/
/******** debug/release env ********/
/********                   ********/
// #define DEBUG

#ifdef DEBUG
#define FNC_RECOMPILE recompile = 1
#else
#define FNC_RECOMPILE recompile = 0
#endif
#endif
