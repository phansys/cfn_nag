# frozen_string_literal: true

require 'spec_helper'
require 'cfn-model'
require 'cfn-nag/custom_rules/LambdaFunctionInsideVPCRule'

describe LambdaFunctionInsideVPCRule do

  describe 'AWS::Lambda::Function' do
    context 'when lambda function is inside VPC' do
      it 'does not return an offending logical resource id' do
        cfn_model_json = CfnParser.new.parse read_test_template('json/lambda_function/lambda_inside_vpc.json')
        actual_logical_resource_ids_json = LambdaFunctionInsideVPCRule.new.audit_impl cfn_model_json

        expect(actual_logical_resource_ids_json).to eq []

        cfn_model_yaml = CfnParser.new.parse read_test_template('yaml/lambda_function/lambda_inside_vpc.yaml')
        actual_logical_resource_ids_yaml = LambdaFunctionInsideVPCRule.new.audit_impl cfn_model_yaml

        expect(actual_logical_resource_ids_yaml).to eq []
      end
    end
  end

  describe 'AWS::Lambda::Function' do
    context 'when lambda function is not inside VPC' do
      it 'does return an offending logical resource id' do
        cfn_model_json = CfnParser.new.parse read_test_template('json/lambda_function/lambda_not_inside_vpc.json')
        actual_logical_resource_ids_json = LambdaFunctionInsideVPCRule.new.audit_impl cfn_model_json

        expect(actual_logical_resource_ids_json).to eq ["FunctionNotInsideVpc"]

        cfn_model_yaml = CfnParser.new.parse read_test_template('yaml/lambda_function/lambda_not_inside_vpc.yaml')
        actual_logical_resource_ids_yaml = LambdaFunctionInsideVPCRule.new.audit_impl cfn_model_yaml

        expect(actual_logical_resource_ids_yaml).to eq ["FunctionNotInsideVpc"]
      end
    end
   end
   
end
