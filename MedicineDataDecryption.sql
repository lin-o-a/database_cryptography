-- Step 1: Open the symmetric key to decrypt columns EncryptedSummary and EncryptedIndication
OPEN SYMMETRIC KEY SymmetricKey
DECRYPTION BY PASSWORD = 'NewPassword';

-- Step 2: Get and decrypt EncryptedSummary and EncryptedIndication
SELECT 
    Summary,
    CAST(DecryptByKey(EncryptedSummary) AS NVARCHAR(MAX)) AS DecryptedSummary,
    Indication,
    CAST(DecryptByKey(EncryptedIndication) AS NVARCHAR(MAX)) AS DecryptedIndication
FROM 
    Medicine;

-- Step 3: Close the symmetric key
CLOSE SYMMETRIC KEY SymmetricKey;
