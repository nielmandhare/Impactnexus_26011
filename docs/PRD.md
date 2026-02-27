PRODUCT REQUIREMENT DOCUMENT (PRD)
Project KISAAN: Smart Agricultural Barter System with RuPay Integration
Version: 1.0
Date: February 27, 2026
Team: [Your Team Name]
Status: Draft for Hackathon Execution

1. INTRODUCTION
1.1 Background
India has over 100 million small and marginal farmers who operate in localized economies with limited access to formal markets, financial liquidity, and transparent price discovery. Most possess surplus produce, equipment, or labor that could be exchanged, but lack structured, trustworthy systems for barter or value-based exchange. Meanwhile, under the Pradhan Mantri Jan Dhan Yojana (PMJDY), over 30 crore RuPay cards have been issued to farmers, yet these cards remain largely unused due to lack of funds in accounts.

1.2 Product Vision
KISAAN (Kisan Integrated Settlement & Asset-Augmentation Network) aims to transform idle agricultural assets into spendable digital value by creating a trust-enabled, voice-first barter exchange platform integrated with the existing RuPay infrastructure and key government schemes. Our vision: "Your Harvest is Your Wallet" – enabling every farmer to use their produce, equipment, and labor as currency for daily needs.

1.3 Objectives
Enable small and marginal farmers to exchange surplus produce, equipment, and services through a transparent barter system.

Provide a trusted valuation mechanism based on Minimum Support Price (MSP) and real-time mandi prices.

Integrate with RuPay cards to allow farmers to spend barter points at local merchants.

Leverage government schemes (PM-KISAN, PMJDY, e-NAM, PMFBY, KCC) for verification, pricing, insurance, and credit.

Ensure accessibility for low-literacy, feature-phone users through voice-first and offline-first design.

Build a community-based verification system using local Sarpanches to establish trust.

Create a scalable, financially sustainable model with multiple revenue streams.

2. PROBLEM STATEMENT
2.1 Core Problem
A large number of small and marginal farmers in India operate within localized economies where direct access to formal markets, financial liquidity, and transparent price discovery is limited. They possess surplus produce, equipment, or labor that could be exchanged, but lack structured and trustworthy systems to enable efficient barter or value-based exchange.

2.2 Key Systemic Challenges
Absence of transparent valuation mechanisms for agricultural goods.

Limited trust and verification in peer-to-peer exchanges.

Geographic and logistical constraints in rural areas.

Lack of structured dispute resolution mechanisms.

Poor integration with formal agricultural supply chains and financial systems.

Dormant RuPay cards – farmers have cards but zero balance, unable to transact.

2.3 Consequences
Reliance on intermediaries leads to distress sales and reduced income.

Inefficient utilization of local resources.

Perpetuation of informal, exploitative credit arrangements.

Exclusion from formal economy and government benefits.

3. USER PERSONAS
Persona	Description	Pain Points	Goals
Ram (Small Farmer)	2 acres, wheat/potatoes, feature phone, low literacy	No cash for diesel, low trader prices, RuPay card unused	Exchange wheat for tractor hours, buy daily needs with points
Shyam (Medium Farmer)	8 acres, tractor idle 6 months, smartphone	Tractor idle, needs labor, wants to expand but no credit history	Rent out tractor for points, hire labor, build credit score
Geeta (Merchant)	Kirana store owner, accepts cash/credit	High default risk, wants more customers	Accept barter points with guaranteed cash settlement
Prakash (FPO Manager)	Manages 500+ farmers	Scattered produce, no collective bargaining	Pool resources, bulk purchase, track government schemes
Sarpanch (Village Head)	Local authority, trusted by community	Wants to help farmers, earn respect/income	Verify barter transactions, resolve disputes, earn rewards
4. SCOPE
4.1 In Scope (for Hackathon MVP)
Farmer onboarding via mobile OTP and face authentication (PM-KISAN mock)

Voice-first listing creation (offer/request) via IVR and app

MSP-based valuation engine (1 point = 80% of MSP per kg)

Matchmaking algorithm (location, trust score, relevance)

Transaction lifecycle (match → verification → completion)

Sarpanch verification via missed call/SMS

Wallet with points balance and transaction history

RuPay payment simulation (farmer pays merchant using points)

Merchant dashboard with settlement options

Family sub-accounts (basic)

Integration with mock government APIs (PM-KISAN, e-NAM, PMFBY)

Multi-language support (Hindi + 2 regional)

4.2 Out of Scope (Post-Hackathon)
Actual NPCI production integration

Physical NFC cards

Full-fledged dispute resolution portal

AI-powered quality assessment via photos

Weather-based predictive matching

Full FPO treasury management

Pan-India merchant onboarding

5. FUNCTIONAL REQUIREMENTS
5.1 Farmer Mobile App (Flutter)
5.1.1 Onboarding & Authentication
ID	Feature	Description	Priority
F1	Mobile OTP registration	Farmer enters mobile, receives OTP via SMS/call	P0
F2	Language selection	Choose preferred language for UI/voice	P0
F3	Face authentication eKYC	Scan face to verify against PM-KISAN mock database	P1
F4	RuPay card linking	Enter existing card or generate virtual card	P1
F5	Profile creation	Name, village, landholding (prefilled from PM-KISAN)	P0
5.1.2 Home Dashboard
ID	Feature	Description	Priority
F6	Points balance card	Show current points and approximate ₹ value	P0
F7	Trust score	Display score and next level progress	P0
F8	Active listings	List of farmer's own listings with expiry	P0
F9	Nearby matches	Horizontal carousel of top matches	P0
F10	Recent transactions	Last 3-5 transactions with status	P0
F11	Quick actions	+ New Listing, Scan QR to Pay	P0
5.1.3 Barter Listings
ID	Feature	Description	Priority
F12	Create listing form	Type, category, item, quantity, quality tier, location, radius, expiry	P0
F13	Voice input	Speech-to-text for all fields	P0
F14	MSP valuation preview	Estimated points before posting	P0
F15	My Listings screen	View active/inactive listings	P0
F16	Edit/delete listing	Modify or remove listing	P1
5.1.4 Match Discovery & Acceptance
ID	Feature	Description	Priority
F17	Matches screen	List of potential barter partners	P0
F18	Match details	Show other farmer's name, distance, items, points, trust score	P0
F19	Accept/Reject	Buttons to accept or reject match	P0
F20	Notification	In-app + SMS on match found	P0
F21	Transaction status	Track lifecycle: pending verification → verified → completed	P0
5.1.5 Wallet & Points
ID	Feature	Description	Priority
F22	Balance display	Current points	P0
F23	Transaction history	Filterable list of all point movements	P0
F24	Points to ₹ explanation	1 point ≈ ₹1 at partner shops	P0
F25	Request payout	Convert up to 30% points to bank (mock)	P2
5.1.6 Payments at Merchant
ID	Feature	Description	Priority
F26	Scan QR code	Pay by scanning merchant QR	P0
F27	Manual merchant code	Enter 6-digit code	P0
F28	Enter amount	Input purchase amount in ₹	P0
F29	Payment method selection	Points only / split	P0
F30	OTP confirmation	Confirm via SMS OTP or missed call	P0
F31	Success screen	Show receipt and remaining balance	P0
F32	Offline QR booklet	Use printed QR pages when phone dead	P1
5.1.7 Family Sub-Accounts
ID	Feature	Description	Priority
F33	Family list	Show sub-accounts with limits and today's spend	P1
F34	Add family member	Name, relationship, daily limit, generate PIN	P1
F35	Freeze/unfreeze	Toggle access	P1
F36	View activity	See transactions per sub-account	P1
F37	Spend alerts	Notify main account on high spends	P2
5.1.8 Community & Information
ID	Feature	Description	Priority
F38	Voice forum	Record questions, listen to replies	P1
F39	Verified expert badges	Show KVK scientists, progressive farmers	P2
F40	Digital magazine	Audio articles for offline listening	P2
F41	Weather forecast	Simple 5-day forecast with voice	P1
F42	Weather-based barter suggestions	Proactive matching based on forecast	P2
5.1.9 Government Scheme Integrations
ID	Feature	Description	Priority
F43	Eligibility checker	Input details → shows eligible schemes (mock)	P1
F44	PMFBY status	Show insurance coverage, claims	P1
F45	e-NAM mandi prices	Chart comparing local mandi with MSP	P1
F46	One-click apply	Prefill and apply to schemes	P2
5.1.10 Settings & Help
ID	Feature	Description	Priority
F47	Change language	Switch app language	P0
F48	Manage RuPay card	View/freeze card	P1
F49	Notification preferences	Choose alert channels	P1
F50	Kisan Call Centre	One-tap call to helpline	P1
F51	FAQ / Help	Voice-enabled common questions	P1
F52	Feedback	Submit voice/text feedback	P2
5.2 Merchant Dashboard (Web)
ID	Feature	Description	Priority
M1	Login via mobile OTP	Simple OTP authentication	P0
M2	Dashboard summary	Today's transactions, pending settlements, earnings	P0
M3	QR code display	Show/print QR for farmers	P0
M4	Manual merchant code	6-digit alphanumeric code	P0
M5	Recent transactions table	Farmer name, amount, date, status	P0
M6	Settlement options	Instant (2% fee), daily (free), hold as points	P0
M7	Settlement history	Past settlements with UTR numbers	P1
M8	Withdraw to bank	Transfer settled amount to bank	P1
M9	Profile settings	Update shop details, bank info	P1
M10	Notification settings	Alert preferences	P2
5.3 Sarpanch Dashboard (Web + SMS)
ID	Feature	Description	Priority
S1	Login via mobile + village code	OTP + village code verification	P0
S2	Pending verifications list	All barter transactions in village awaiting verification	P0
S3	Verification details	Farmer names, items, points, call buttons	P0
S4	Verify via call/SMS	Missed call or SMS to verify	P0
S5	Dispute resolution	View evidence, choose resolution, record decision	P1
S6	Earnings history	Show rewards (₹10 per verification)	P1
S7	Village activity dashboard	Charts of barter volume, trust scores	P2
5.4 FPO Dashboard (Web)
ID	Feature	Description	Priority
FP1	Login	FPO admin credentials	P0
FP2	Collective view	Total members, pooled points, active listings	P0
FP3	Bulk operations	Collective offers, bulk purchase, dividend distribution	P1
FP4	Member list	View members with trust scores, volumes	P1
FP5	Scheme tracking	Show scheme enrollment per member	P1
FP6	Reports	Generate subsidy claims, activity reports	P2
5.5 Admin Panel (Web)
ID	Feature	Description	Priority
A1	System dashboard	Total users, transactions, points issued, map view	P0
A2	User management	Search/freeze users	P0
A3	Transaction monitoring	Filter transactions by status	P0
A4	Dispute queue	View escalated disputes	P1
A5	Trust score adjustments	Manual override for testing	P1
A6	Scheme sync status	Show last sync with govt APIs	P1
A7	Analytics	Charts on adoption, volume, revenue	P2
6. NON-FUNCTIONAL REQUIREMENTS
ID	Requirement	Description	Target
N1	Performance	IVR call setup <10s, transaction confirmation <30s	Hackathon demo
N2	Scalability	Handle 10,000 concurrent users (architecture design)	Future
N3	Availability	99.5% uptime (demo: 100%)	Hackathon
N4	Security	End-to-end encryption, OTP for all financial ops	Implement
N5	Accessibility	Voice-first, support 4+ languages, feature phone compatible	P0
N6	Offline capability	App stores last 100 transactions, sync when online	P1
N7	Data privacy	No storage of full Aadhaar, only last 4 digits + hash	Implement
7. TECHNICAL ARCHITECTURE
7.1 High-Level Architecture Diagram
text
┌─────────────────────────────────────────────────────────────┐
│                        CLIENT LAYERS                          │
├───────────────┬───────────────┬───────────────┬─────────────┤
│   Flutter App │   React Web   │   IVR (Twilio)│   SMS/USSD  │
│   (Farmer)    │ (Merchant/FPO)│               │             │
└───────┬───────┴───────┬───────┴───────┬───────┴──────┬──────┘
        │               │               │               │
        ▼               ▼               ▼               ▼
┌─────────────────────────────────────────────────────────────┐
│                        API GATEWAY                            │
│                    (Express.js / FastAPI)                     │
└─────────────────────────────────────────────────────────────┘
        │               │               │               │
        ▼               ▼               ▼               ▼
┌─────────────────────────────────────────────────────────────┐
│                      SERVICE LAYER                             │
├───────────────┬───────────────┬───────────────┬─────────────┤
│  Auth Service │  Barter Match │  Voice2Text   │ Wallet      │
│  Transaction  │  Settlement   │  Credit Score │ Notification│
└───────┬───────┴───────┬───────┴───────┬───────┴──────┬──────┘
        │               │               │               │
        ▼               ▼               ▼               ▼
┌─────────────────────────────────────────────────────────────┐
│                        DATA LAYER                              │
├───────────────┬───────────────┬───────────────┬─────────────┤
│   PostgreSQL  │    Redis      │    S3/Cloud   │ Elasticsearch│
│   (Primary)   │   (Cache)     │   (Voice)     │   (Search)   │
└───────────────┴───────────────┴───────────────┴─────────────┘
        │               │               │               │
        ▼               ▼               ▼               ▼
┌─────────────────────────────────────────────────────────────┐
│                    EXTERNAL INTEGRATIONS                       │
├───────────────┬───────────────┬───────────────┬─────────────┤
│  PM-KISAN     │   e-NAM       │  NPCI/RuPay   │   PMFBY     │
│  (Mock)       │   (Mock)      │  (Sandbox)    │   (Mock)    │
└───────────────┴───────────────┴───────────────┴─────────────┘
7.2 Technology Stack
Layer	Technology	Justification
Mobile App	Flutter	Cross-platform, fast development
Web Dashboard	React + Tailwind	Responsive, component-based
Backend API	Node.js (Express)	Rapid development, large ecosystem
Database	PostgreSQL	ACID compliance for transactions
Cache	Redis	Session management, rate limiting
Voice	Twilio + Google STT	Reliable IVR, high accuracy for Indian languages
SMS	Twilio/TextLocal	Delivery reports
File Storage	AWS S3	Voice recordings
Authentication	JWT + OTP	Simple, secure
8. INTEGRATION POINTS
Government Scheme	Data Used	Integration Method (Hackathon)
PM-KISAN	Farmer verification, landholding	Mock database with 1000 farmers; face auth simulation
PMJDY	RuPay card, bank account	NPCI sandbox; virtual card generation
e-NAM	Mandi prices	Pre-populated sample prices; API mock
MSP	Valuation benchmark	Hardcoded latest MSP values
PMFBY	Insurance status	Mock insurance trigger; claim simulation
KCC	Credit limit	Mock credit enhancement display
CSC	Service centers	Mock as verification/onboarding points
9. EDGE CASES & MITIGATIONS
Edge Case	Mitigation
Farmer has no smartphone	Voice-first IVR, SMS, USSD (*99# style)
No internet connectivity	Offline transaction queue; SMS fallback
Phone battery dead	Printed QR booklet for merchant payments
Illiterate farmer	Voice navigation, color-coded cards, icons
Family member misuse	Sub-accounts with daily limits; main account alerts
Crop failure / unable to repay	PMFBY insurance integration; grace period
Quality dispute	Sarpanch verification; voice evidence; tiered quality system
Merchant refuses points	Instant settlement option; merchant incentives
Sarpanch corrupt	Multiple Sarpanches per village; random audits; trust score
Network failure during transaction	SMS-based confirmation; offline queue
Farmer forgets PIN	Biometric backup; voice PIN; trusted contact reset
10. SUCCESS METRICS (Hackathon Evaluation)
Metric	Target
Problem understanding	⭐⭐⭐⭐⭐ (Edge cases documented)
Innovation	⭐⭐⭐⭐⭐ (RuPay + barter + voice-first + govt schemes)
Technical complexity	⭐⭐⭐⭐⭐ (IVR, offline, NPCI mock, multi-channel)
User experience	⭐⭐⭐⭐⭐ (Works for illiterate, feature phones, no internet)
Scalability	⭐⭐⭐⭐⭐ (Architecture for 1M farmers)
Impact	⭐⭐⭐⭐⭐ (Solves liquidity for 100M farmers)
Business model	⭐⭐⭐⭐ (4 revenue streams)
Demo quality	⭐⭐⭐⭐⭐ (Live working prototype)
11. ROADMAP
Phase 1: Hackathon MVP (24 hours)
Core barter flow (offer → match → verify → complete)

Voice-first listing via IVR

RuPay payment simulation

Merchant settlement (mock)

Sarpanch verification

Family sub-accounts (basic)

Integration with mock government APIs

Multi-language support (Hindi + 2)

Phase 2: Pilot (Month 1-3)
Onboard 500 farmers in 10 villages

Integrate with actual NPCI sandbox

Onboard 50 merchants

Enhance offline capabilities

Refine trust score algorithm

Phase 3: Scale (Month 4-12)
Expand to 3 states

Partner with 5 FPOs

Integrate with live e-NAM APIs

Add AI disease diagnosis

Launch FPO treasury management

Apply for TPAP/BBPOU licenses

Phase 4: National Rollout (Year 2)
Pan-India presence

10 million farmers

100,000 merchants

Full integration with all relevant government schemes

Export model to other developing nations

12. APPENDIX
12.1 Glossary
Term	Definition
KISAAN	Kisan Integrated Settlement & Asset-Augmentation Network
Barter Points	Digital unit representing value, 1 point ≈ ₹1 at partner shops
Trust Score	Algorithmic score based on transaction history, verifications
Sarpanch	Village head, local authority for verification
FPO	Farmer Producer Organization
MSP	Minimum Support Price
PMJDY	Pradhan Mantri Jan Dhan Yojana
PM-KISAN	PM Kisan Samman Nidhi
PMFBY	PM Fasal Bima Yojana
e-NAM	National Agriculture Market
KCC	Kisan Credit Card
12.2 References
PM-KISAN Dashboard: https://pmkisan.gov.in

e-NAM: https://www.enam.gov.in

NPCI RuPay: https://www.npci.org.in

