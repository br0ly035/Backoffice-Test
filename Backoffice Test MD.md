# 3.1 - Understand the Industry
The whole process when a payment is made, also known as credit card transaction flow or authorization flow will involve the following agents, steps or processes: 

- Customer (cardholder);
- Merchant;
- Checkout + Point of Sale terminal (POS);
- Acquirer;
- Payment Schemes:
- Issuer (for credit card account validation);

Acquirer has the function of settling the financial transactions carried out through the credit and/or debit card. They communicate directly with the card brands/flags and the issuing banks.
When the purchase is approved between the card association and the financial institution, the acquirer receives the money from the card issuer and passes it on to the merchant.
In the case of sub acquirers, institutions such as "PagSeguro", Paypal, among others, are responsible for intermediating payments between all parties involved, such as acquirers, merchants and customers. 
This service is directed at data security with protection against fraud, encompassing all stages of the process, including the gateways.
Therefore, the payment gateways have the role of processing the information at the moment the purchase is finalised at the checkout. In other words to effect the purchase.
The KYC (Know Your Customes) is the process of analysis of customer data that is consistent with the movements and origins of their financial resources, verifying the authenticity of the information and data validation. 
For institutions to know their customers in depth, it is necessary to establish which data will be collected and stored. For example, information on income, assets and investments. This way, the bank can point out suspicious transactions. 
It is a security measure for institutions and is part of the compliance policies and programs to avoid financial losses, fraud prevention and possible scams, judicial convictions and damage to the image and fight the promotion of illicit activities such as money laundering and corruption.

# 3.2 - Get your hands dirty
## Process

*for each one of the steps of the "Backoffice Test" I copied the sub queries to follow the challenge plan;

- 1: For better visualization, I have separated the times according to their status in each of the Sub-queries;

- 2: At the end I like to add the all the previous informations in a sub query called "Final", to be able to model them in the necessary way and gather all the important information, making it possible to afterwards remove any unecessary data for the analysis;

- 3: For better visualization and possible future use of the data, I decided to provide the time difference both in hh:mm and in total minutes. This could also help in case I need to filter a range of minutes;

-  4: In the last table, it was possible to verify that the MIN values requested were negative number (which should be impossible for this problem in specific). So, in order to understand the issue within the data, I built a "check" query that will show me how many cases I had with this problem (negative values);

- 5: Knowing the exact users that were presenting the problem, it was possible for me to check their specific data, analyze it and fix the problem. Apparently, those customers were having "inactive" statuses issues, making their purchase delayed and  making it necessary to start over the purchasing process;

- 6: Understanding that the dates that I was comparing were from different process, I specified the row I wanted to get by ordering it by the most recent date [using the: row_number () over (partition by - order by -)];

- 7: Now that I ensured that the data was the most recent ones and without cross-referencing the data between dates, I simply rewrote the queries and managed to get the desired results.


# 4 - Deliverables
*due to the large number of lines, only a portion of the final result will be shown
## Final Answers

**All the CNPJs, the dates of purchase and how long it took to approve each merchant**
| | cnpj | purchase_date | time_it_took | time_in_min |
| ------ | ------ | ------ | ------ | ------ |
1 | 244886000280 | 2022-02-08 | 0:22 | 22 |
2 | 262892000204 | 2022-02-08 | 1:21 | 81 |
3 | 422868000202 | 2022-02-08 | 0:04 | 4 |
4 | 2086224000240 | 2022-02-08 | 0:05 | 5 |
5 | 2208222000264 | 2022-02-08 | 0:02 | 2 |
6 | 2284426000260 | 2022-02-08 | 0:04 | 4 |
7 | 2604646000262 | 2022-02-08 | 0:14 | 14 |
... | ... | ... | ... | ... |

**Calculate the average time of approval, and the maximum and minimum time of approval**
| |avg_approval_time | avg_approval_minute | min_approval_time | min_approval_minute | max_approval_time | max_approval_minute |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ |
1 | 14:13	| 853 |	0:02 | 2 |	348:26 | 20906
