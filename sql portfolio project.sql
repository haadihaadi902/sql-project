create DATABASE sql_portfolio_project

select * from project

-- Step 1: Calculate the total average monthly charges for churned customers
--         and group them by age and contract type (Offer).

-- Step 1: Calculate the total average monthly charges for churned customers
--         and group them by age and contract type (Offer).

#	Q1
SELECT Age, Offer AS Contract_Type, 
       AVG(`Avg Monthly Long Distance Charges` + `Avg Monthly GB Download`) AS Total_Avg_Monthly_Charges
FROM project_data
WHERE `Churn Label` = 'Yes'
GROUP BY Age, Offer
ORDER BY Total_Avg_Monthly_Charges DESC
LIMIT 5;

#To tailor personalized offers based on the top 5 groups with the highest average monthly charges among churned customers, let’s break it down into specific strategies by considering the following factors: age, contract type (Offer), and gender (if available).

/*1. Age-Based Tailoring:
Young customers (18–30 years): These customers typically value flexibility, technology perks, and data-heavy plans. Offering them:
Unlimited data packages or bundled entertainment services (like Netflix or Spotify).
Referral bonuses for bringing in friends or family members to the service.
Flexible contract lengths to cater to their dynamic needs.
Middle-aged customers (31–50 years): They may be interested in value-added services and cost-efficient plans. Potential offers could include:
Discounted family plans or multi-line packages.
Tech support bundles for smart home devices.
Loyalty rewards programs to emphasize retention and offer incremental rewards for staying.
Older customers (50+ years): They may prioritize reliability and simplicity. Offers for them might include:
Senior discounts on their current plans.
Simplified service packages focusing on essentials like strong phone service and limited data.
Customer service enhancements, such as priority support or personalized assistance.
2. Contract Type (Offer)-Based Tailoring:
Prepaid or No Contract (e.g., Offer A): Customers who chose prepaid offers or flexible contracts are likely price-sensitive and prefer control over their spending. Personalized offers could focus on:
Discounts for auto-renewals or signing up for longer-term plans.
Pay-as-you-go flexibility with perks, such as data rollovers or waived activation fees.
Long-term Contracts (e.g., Offer C or D): These customers may churn if they find a better deal elsewhere. Potential personalized offers to retain them include:
Contract upgrades with added benefits like free hardware upgrades (phones, routers, etc.).
Exclusive access to premium services (faster internet, additional data for free, etc.) to make staying in the contract more appealing.
Early renewal bonuses, offering discounts if they renew early or extend the contract.
Unlimited Plans (e.g., Offer E): High data users might be enticed with:
Loyalty perks such as free subscriptions to services or data expansions.
Data booster packs during high-demand periods (like vacations) or in regions with low connectivity.
3. Gender-Based Tailoring (if gender data is available):
While gender data can provide useful insights, personalization here should focus more on general lifestyle preferences and behavior rather than stereotypes. If available, the focus could be on lifestyle-oriented offers based on actual usage, preferences, and satisfaction scores rather than purely gender-driven strategies.
For example, you could analyze the data to see if particular lifestyle packages (entertainment, family plans, travel data, etc.) appeal more to specific genders.
Example of a Tailored Strategy:
Let’s say from the SQL query, one of the groups is young customers (age 25–30) on Offer C (long-term contract) with high monthly charges. To retain them, the company could offer:

Flexible plan adjustments: Allow them to adjust their data or services on demand without changing the contract.
Data rollover plans: So they don’t feel they are losing unused data.
Loyalty programs: Reward them with points or credits for their high usage and offer phone upgrades or service discounts if they stay longer.
Action Plan for Implementation:
Data analysis: Use your SQL query to identify the specific characteristics of high-value churned customers in terms of age and contract type. Identify common reasons for churn (e.g., price, dissatisfaction, or competitor offers) using columns like Churn Reason.
Design offers: Tailor personalized offers to address the reasons for churn. If price sensitivity is an issue, design more flexible or discounted packages. If network coverage is a concern, offer free data boosts in underperforming areas.
Marketing and Communication: Use targeted marketing to reach these high-value groups with the tailored offers through email, SMS, or app notifications. Emphasize the specific benefits and ease of switching back to your services.
By using this personalized approach, based on a deeper understanding of the high-churn groups, you can directly address customer needs and improve retention rates.*/


#Q2

SELECT `Churn Reason`, COUNT(*) AS Number_of_Customers
FROM project_data
WHERE `Churn Label` = 'Yes'
GROUP BY `Churn Reason`
ORDER BY Number_of_Customers DESC;

#explanation

/* SELECT Churn Reason, COUNT(*): This selects the Churn Reason for churned customers and counts the number of times each reason appears.
FROM project_data: Specifies that the query is from the project_data table.
WHERE Churn Label = 'Yes': Filters the dataset to include only churned customers.
GROUP BY Churn Reason: Groups the results by the Churn Reason, which helps to aggregate similar feedback or complaints.
ORDER BY Number_of_Customers DESC: Orders the results in descending order based on the number of customers who gave the same reason for churning. This allows you to see the most frequent complaints first */

#Q3

SELECT `Payment Method`, 
       COUNT(CASE WHEN `Churn Label` = 'Yes' THEN 1 END) AS Churned_Customers,
       COUNT(*) AS Total_Customers,
       (COUNT(CASE WHEN `Churn Label` = 'Yes' THEN 1 END) / COUNT(*)) * 100 AS Churn_Rate_Percentage
FROM project_data
GROUP BY `Payment Method`
ORDER BY Churn_Rate_Percentage DESC;


/* Explanation:
SELECT Payment Method: Selects the Payment Method column to analyze the influence of different payment methods.
COUNT(CASE WHEN Churn Label = 'Yes' THEN 1 END) AS Churned_Customers: Counts the number of churned customers for each payment method.
COUNT(*) AS Total_Customers: Counts the total number of customers for each payment method.
(COUNT(CASE WHEN Churn Label = 'Yes' THEN 1 END) / COUNT(*)) * 100 AS Churn_Rate_Percentage: Calculates the churn rate as a percentage for each payment method by dividing the number of churned customers by the total number of customers and multiplying by 100.
GROUP BY Payment Method: Groups the results by each payment method to provide insights on how each influences churn behavior.
ORDER BY Churn_Rate_Percentage DESC: Orders the results by churn rate percentage in descending order, so you can see which payment methods have the highest churn rates.*/