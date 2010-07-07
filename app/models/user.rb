# encoding: utf-8

class User < ActiveRecord::Base

  has_many :collections
  has_many :literatures
  has_many :scratchpads
  has_many :viewed_literatures, :through => :literature_votes, :source => :literature
  has_many :literature_votes
  
  validates_uniqueness_of :name, :allow_blank => true, :message => "is not available" 
  validates_presence_of :name, :if => :confirmed, :message => "can't be blank"
  validates_length_of :name, :within => 4..20, :if => :confirmed, :message => "must be between 4 and 20 characters long"
  validates_format_of :name, :with => /\A[A-Za-z0-9-._]+\Z/i, :if => :confirmed
  
  validates_presence_of :openid_url
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => :confirmed
  validates_format_of :website, :with => /^https?:\/\/[^"]+/, :allow_blank => true
  
  attr_accessible :email, :openid_url, :biography, :closed_at, :api_key, :website, :last_accessed_at
  
  def rank
    self[:rank] ||= 0
  end
  
  RANKS = {
    :super_admin => {
      :name => "Lycaon pictus",
      :range => 100..100,
      :value => 100,
      :symbol => "炎", #fire
    },
    :admin => {
      :name => "Canid",
      :range => 80..99,
      :value => 90,
      :symbol => "犬", #dog
    },
    :moderator => {
      :name => "Citrus Bush",
      :range => 50..79,
      :value => 70,
      :symbol => "木", #tree
    },
    :user => {
      :name => "Legume",
      :range => 0..49,
      :value => 0,
      :symbol => '豆' #one
      #:symbol => "草", #grass
    },
    :unknown => {
      :name => "Unknown",
      :range => (-100..-100),
      :value => -100,
      :symbol => "",
    }
    # :closed => {
    #   :name => "Fungi",
    #   :range => -10..-1,
    #   :value => -5,
    # },
    # :banned => {
    #   :name => "Deadis treeus",
    #   :range => -25..-10,
    #   :value => -15,
    # },
  }
  
  def rank_sym
    RANKS.each { |k, v|
      return k if v[:range].include? self.rank
    }
    :unknown
  end
  
  def rank_name
    RANKS[self.rank_sym][:name]
  end
  
  def rank_symbol
    RANKS[self.rank_sym][:symbol]
  end
  
  def super_admin?
    RANKS[:admin][:range].include? 100
  end
  
  def admin?
    RANKS[:admin][:range].min <= self.rank
  end
  
  def has_rank?(rank_or_sym)
    rank_or_sym = RANKS[rank_or_sym][:range].min if rank_or_sym.is_a? Symbol
    (self.rank >= rank_or_sym)
  end
  
  def to_param
    "#{self.id}-#{self.name.try :parameterize}"
  end
end
