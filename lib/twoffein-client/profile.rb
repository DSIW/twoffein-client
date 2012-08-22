#!/usr/bin/env ruby
# encoding: utf-8

require_relative "http"
require_relative "constants"

module Twoffein
  Profile = Struct.new(:quest,
      :drink,
      :rank,
      :rank_title,
      :drunken,
      :bluttwoffeinkonzentration,
      :first_login,
      :screen_name)

  class Profile
    def initialize(hash=nil)
      return super(*hash) if hash.nil?
      hash.each { |key,val| self[key] = val if members.include? key }
    end

    def self.get(profile="")
      new(HTTP.get("profile", :profile => profile))
    end

    def to_s
      hash = instance_hash
      max_length = hash.keys.map { |k| k.length }.max

      hash.map { |attr, value|
        attr = attr.to_sym

        if attr == :first_login
          value = human_readable_time(value)
        end

        postfix = ":"
        attr = human_readable_key(attr) + postfix

        "#{attr.to_s.ljust(max_length+postfix.length+1)}#{value}"
      }.join("\n")
    end

    private

    def instance_hash
      members.reduce({}) do |hash, ivar|
        hash.merge({ivar.to_sym => self[ivar]})
      end
    end

    def human_readable_key(key)
      key.to_s.gsub('_', ' ').split(/(\W)/).map(&:capitalize).join
    end

    def human_readable_time(value)
      Time.at(value.to_i).strftime("%Y-%m-%d %H:%M")
    end
  end
end
