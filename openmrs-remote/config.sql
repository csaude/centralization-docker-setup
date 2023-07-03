INSERT INTO global_property (property,property_value,uuid)
VALUES ('esaudefeatures.opencr.remote.server.url', 'https://opencr-dev:3000', '1aa8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('esaudefeatures.opencr.remote.server.username', 'root@intrahealth.org', '2aa8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('esaudefeatures.opencr.remote.server.password', 'intrahealth', '3aa8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('esaudefeatures.openmrs.remote.server.url', 'http://openmrs-central-dev:8080/openmrs', '4aa8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('esaudefeatures.openmrs.remote.server.username', 'admin', '5aa8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('esaudefeatures.openmrs.remote.server.password', 'Admin123', '6aa8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('esaudefeatures.remote.server.skip.hostname.verification', 'TRUE', '9aa8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('esaudefeatures.remote.server.type', 'OPENCR', '0aa8f66d-98b8-4829-a5af-d063376cd5c1');

-- UPDATE global_property SET property_value = 'https://opencr-dev:3000' WHERE property = 'esaudefeatures.opencr.remote.server.url';
-- UPDATE global_property SET property_value = 'root@intrahealth.org' WHERE property = 'esaudefeatures.opencr.remote.server.username';
-- UPDATE global_property SET property_value = 'intrahealth' WHERE property = 'esaudefeatures.opencr.remote.server.password';
-- UPDATE global_property SET property_value = 'http://openmrs-central-dev:8080/openmrs' WHERE property = 'esaudefeatures.openmrs.remote.server.url';
-- UPDATE global_property SET property_value = 'admin' WHERE property = 'esaudefeatures.openmrs.remote.server.username';
-- UPDATE global_property SET property_value = 'Admin123' WHERE property = 'esaudefeatures.openmrs.remote.server.password';
-- UPDATE global_property SET property_value = 'TRUE' WHERE property = 'esaudefeatures.remote.server.skip.hostname.verification';
-- UPDATE global_property SET property_value = 'OPENCR' WHERE property = 'esaudefeatures.remote.server.type';
