-- First Query - execute as a separate query
-- Step 1: Add columns to hold encrypted medicine summary and indication
-- EncryptedSummary, EncryptedIndication columns
ALTER TABLE Medicine
ADD 
    EncryptedSummary VARBINARY(MAX),
    EncryptedIndication VARBINARY(MAX);

-- Second Query - execute as a separate query
-- Step 2: Create a symmetric key to encrypt and decrypt summary and indication
CREATE SYMMETRIC KEY SymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY PASSWORD = 'NewPassword';

-- Third Query - execute as a separate query
-- Step 3: Open the symmetric key to encrypt summary and indication
OPEN SYMMETRIC KEY SymmetricKey
DECRYPTION BY PASSWORD = 'NewPassword';

-- Step 4: Encrypt the nvarchar(max) column
UPDATE Medicine
SET 
    EncryptedSummary = EncryptByKey(Key_GUID('SymmetricKey'), Summary),
    EncryptedIndication = EncryptByKey(Key_GUID('SymmetricKey'), Indication);

-- Step 5: Close the symmetric key
CLOSE SYMMETRIC KEY SymmetricKey;
